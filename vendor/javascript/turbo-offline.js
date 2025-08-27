/*!
Turbo 8.0.13
Copyright © 2025 37signals LLC
 */
class Rule {
  constructor({ handler, match = /.*/ } = {}) {
    this.handler = handler;
    this.match = match;
  }

  matches(request) {
    if (typeof this.match === 'function') return this.match(request)

    const regexes = Array.isArray(this.match) ? this.match : [this.match];
    return regexes.some(regex => regex.test(request.url))
  }

  async handle(event) {
    const { response, afterHandlePromise } = await this.handler.handle(event.request);
    event.waitUntil(afterHandlePromise);

    return response
  }
}

class ServiceWorker {
  #started = false
  #rules = []

  addRule(rule) {
    this.#rules.push(new Rule(rule));
  }

  start() {
    this.#warnIfNoRulesConfigured();

    if (!this.#started) {
      self.addEventListener("install", this.installed);
      self.addEventListener("message", this.messageReceived);
      self.addEventListener("fetch", this.fetch);
      this.#started = true;
    }
  }

  installed = (event) => {
    // Just log for now
    console.log("Service worker installed");
  }

  messageReceived = (event) => {
    if (this[event.data.action]) {
      const actionCall = this[event.data.action](event.data.params);
      event.waitUntil(actionCall);
    }
  }

  fetch = (event) => {
    if (this.#canInterceptRequest(event.request)) {
      const rule = this.#findMatchingRule(event.request);
      if (!rule) return

      const response = rule.handle(event);
      event.respondWith(response);
    }
  }

  #warnIfNoRulesConfigured() {
    if (this.#rules.length === 0) {
      console.warn("No rules configured for service worker. No requests will be intercepted.");
    }
  }

  #canInterceptRequest(request) {
    const url = new URL(request.url, location.href);
    return request.method === "GET" && url.protocol.startsWith('http')
  }

  #findMatchingRule(request) {
    return this.#rules.find((rule) => rule.matches(request))
  }
}

const DATABASE_NAME = "turbo-offline-database";
const DATABASE_VERSION = 1;
const STORE_NAME = "cache-registry";

class CacheRegistryDatabase {
  get(cacheName, key) {
    const getOp = (store) => this.#requestToPromise(store.get(key));
    return this.#performOperation(STORE_NAME, getOp, "readonly")
  }

  has(cacheName, key) {
    const countOp = (store) => this.#requestToPromise(store.count(key));
    return this.#performOperation(STORE_NAME, countOp, "readonly").then((result) => result === 1)
  }

  put(cacheName, key, value) {
    const putOp = (store) => {
      const item = { key: key, cacheName: cacheName, timestamp: Date.now(), ...value };
      store.put(item);
      return this.#requestToPromise(store.transaction)
    };

    return this.#performOperation(STORE_NAME, putOp, "readwrite")
  }

  getTimestamp(cacheName, key) {
    return this.get(cacheName, key).then((result) => result?.timestamp)
  }

  getOlderThan(cacheName, timestamp) {
    const getOlderThanOp = (store) => {
      const index = store.index("cacheNameAndTimestamp");
      // Use compound key range: [cacheName, timestamp]
      const range = IDBKeyRange.bound(
        [cacheName, 0], // start of range
        [cacheName, timestamp], // end of range
        false, // lowerOpen: include lower bound
        true // upperOpen: exclude upper bound
      );
      const cursorRequest = index.openCursor(range);

      return this.#cursorRequestToPromise(cursorRequest)
    };
    return this.#performOperation(STORE_NAME, getOlderThanOp, "readonly")
  }

  delete(cacheName, key) {
    const deleteOp = (store) => this.#requestToPromise(store.delete(key));
    return this.#performOperation(STORE_NAME, deleteOp, "readwrite")
  }

  #performOperation(storeName, operation, mode) {
    return this.#openDatabase().then((database) => {
      const transaction = database.transaction(storeName, mode);
      const store = transaction.objectStore(storeName);
      return operation(store)
    })
  }

  #openDatabase() {
    const request = indexedDB.open(DATABASE_NAME, DATABASE_VERSION);
    request.onupgradeneeded = () => {
      const cacheMetadataStore = request.result.createObjectStore(STORE_NAME, { keyPath: "key" });
      cacheMetadataStore.createIndex("cacheNameAndTimestamp", [ "cacheName", "timestamp" ]);
    };

    return this.#requestToPromise(request)
  }

  #requestToPromise(request) {
    return new Promise((resolve, reject) => {
      request.oncomplete = request.onsuccess = () => resolve(request.result);
      request.onabort = request.onerror = () => reject(request.error);
    })
  }

  #cursorRequestToPromise(request) {
    return new Promise((resolve, reject) => {
      const results = [];

      request.onsuccess = (event) => {
        const cursor = event.target.result;
        if (cursor) {
          results.push(cursor.value);
          cursor.continue();
        } else {
          resolve(results);
        }
      };

      request.onerror = () => reject(request.error);
    })
  }
}

let cacheRegistryDatabase = null;

function getDatabase() {
  if (!cacheRegistryDatabase) {
    cacheRegistryDatabase = new CacheRegistryDatabase();
  }
  return cacheRegistryDatabase
}

class CacheRegistry {
  constructor(cacheName) {
    this.cacheName = cacheName;
    this.database = getDatabase();
  }

  get(key) {
    return this.database.get(this.cacheName, key)
  }

  has(key) {
    return this.database.has(this.cacheName, key)
  }

  put(key, value = {}) {
    return this.database.put(this.cacheName, key, value)
  }

  getTimestamp(key) {
    return this.database.getTimestamp(this.cacheName, key)
  }

  getOlderThan(timestamp) {
    return this.database.getOlderThan(this.cacheName, timestamp)
  }

  delete(key) {
    return this.database.delete(this.cacheName, key)
  }
}

class CacheTrimmer {
  #isRunning = false

  constructor(cacheName, cacheRegistry, options = {}) {
    this.cacheName = cacheName;
    this.cacheRegistry = cacheRegistry;
    this.options = options;
  }

  async trim() {
    if (this.#isRunning) {
      return
    }

    if (!this.#shouldTrim()) {
      return
    }

    this.#isRunning = true;

    try {
      await this.deleteEntries();
    } finally {
      this.#isRunning = false;
    }
  }

  #shouldTrim() {
    // For now, only check maxAge. To be extended for maxEntries, maxStorage, etc.
    return this.options.maxAge && this.options.maxAge > 0
  }

  async deleteEntries() {
    if (this.options.maxAge) {
      await this.deleteEntriesByAge();
    }
    // To be extended with other options
  }

  async deleteEntriesByAge() {
    const maxAgeMs = this.options.maxAge * 1000;
    const cutoffTimestamp = Date.now() - maxAgeMs;

    const expiredEntries = await this.cacheRegistry.getOlderThan(cutoffTimestamp);

    if (expiredEntries.length === 0) {
      return
    }

    console.debug(`Trimming ${expiredEntries.length} expired entries from cache "${this.cacheName}"`);

    const cache = await caches.open(this.cacheName);

    const deletePromises = expiredEntries.map(async (entry) => {
      const cacheDeletePromise = cache.delete(entry.key);
      const registryDeletePromise = this.cacheRegistry.delete(entry.key);

      return Promise.all([cacheDeletePromise, registryDeletePromise])
    });

    await Promise.all(deletePromises);

    console.debug(`Successfully trimmed ${expiredEntries.length} entries from cache "${this.cacheName}"`);
  }
}

class Handler {
  constructor({ cacheName, networkTimeout, maxAge }) {
    this.cacheName = cacheName;
    this.networkTimeout = networkTimeout;

    this.cacheRegistry = new CacheRegistry(cacheName);
    this.cacheTrimmer = new CacheTrimmer(cacheName, this.cacheRegistry, { maxAge });
  }

  async handle(request) {
    // Abstract method
  }

  async fetchFromCache(request) {
    const cacheKeyUrl = buildCacheKey(request);
    let response = await caches.match(cacheKeyUrl, { ignoreVary: true });

    if (response !== undefined && request.redirect === "manual" && response.redirected) {
      // Can't respond with a redirected response to a request
      // whose redirect mode is not "follow". Since we can't cache
      // the request with manual redirect mode because these might be
      // crawled in advance, when we don't know how these will be requested,
      // we just return the body here.
      response = new Response(response.body, { headers: response.headers, status: response.status, url: response.url });
    }

    return response
  }

  async fetchFromNetwork(request) {
    // Setting the referrer so that it doesn't appear as the service worker
    const referrer = request.referrer;
    return await fetch(request, { referrer })
  }

  async saveToCache(request, response) {
    if (response && this.canCacheResponse(response)) {
      const cacheKeyUrl = buildCacheKey(request, response);
      const cache = await caches.open(this.cacheName);

      const cachePromise = cache.put(cacheKeyUrl, response);
      const registryPromise = this.cacheRegistry.put(cacheKeyUrl);
      const trimPromise = this.cacheTrimmer.trim();

      return Promise.all([ cachePromise, registryPromise, trimPromise ])
    }
  }

  canCacheResponse(response) {
    // OK response and opaque responses (due to CORS), that have a 0 status
    return response.status === 200 || response.status === 0
  }
}

function buildCacheKey(requestOrUrl, response) {
  // If the response is HTML, cache always based on the final response's request url, so
  // that Turbo HTTP location redirects are not masked. Otherwise, cached based on the
  // original request url, so redirected images, resources, etc are available offline.
  // We don't have a response when responding from the cache because, so in that case,
  // we need to use the request's URL always. This is also the case when we want to
  // check the URL in our key-value store to see if we have a fresh version already.
  const request = new Request(requestOrUrl);
  const url = response && isHtmlResponse(response) ? response.url : request.url;
  return new URL(url, location.href).href
}

function isHtmlResponse(response) {
  return response.headers.get("content-type")?.includes("text/html")
}

/**
 * Cache-first: try the cache. If it's a hit, return that. If it's a miss,
 * fall back to network and then cache the response.
 */

class CacheFirst extends Handler {
  async handle(request) {
    let response = await this.fetchFromCache(request);
    let afterHandlePromise;

    if (response) {
      // Always trim the cache when using a response in cache-first strategy
      // because if we are always returning cached content and never saving
      // any new content, it will all eventually become older than maxAge
      afterHandlePromise = this.cacheTrimmer.trim();
      return { response, afterHandlePromise }
    }

    console.debug(`Cache miss for ${request.url}`);

    try {
      response = await this.fetchFromNetwork(request);
    } catch(error) {
      console.warn(
        `${error} fetching from network ${request.url}`
       );
    }

    if (response) {
      afterHandlePromise = this.saveToCache(request, response.clone());
    }

    return { response, afterHandlePromise }
  }

  canCacheResponse(response) {
    // Only cache OK responses, as we don't want to cache a network error
    // by mistake, which is impossible to distinguish from an opaque
    // response with status 0
    return response.status === 200
  }
}

/**
 * Network-first: try the network, with an optional time out, and if that fails
 * fallback to the cache
 */

class NetworkFirst extends Handler {
  async handle(request) {
    let response;
    let afterHandlePromise;
    let timeoutId;
    let cacheAttemptedOnTimeout = false;

    const networkPromise = this.fetchFromNetwork(request);
    const promises = [networkPromise];

    if (this.networkTimeout) {
      const timeoutPromise = new Promise((resolve) => {
        timeoutId = setTimeout(async () => {
          console.debug(`Network timeout after ${this.networkTimeout}s for ${request.url}, trying the cache...`);

          const cachedResponse = await this.fetchFromCache(request);
          cacheAttemptedOnTimeout = true;

          resolve(cachedResponse);
        }, this.networkTimeout * 1000);
      });
      promises.push(timeoutPromise);
    }

    try {
      // Either the network wins or the timeout wins. The network might win
      // with an error, though
      response = await Promise.race(promises);
    } catch(error) {
      console.warn(
        `${error} fetching from network ${request.url} with timeout`
      );
    }

    if (timeoutId) clearTimeout(timeoutId);

    if (!response && cacheAttemptedOnTimeout) {
      // In this case we know we hit the timout and got a cache miss.
      // We can wait for the network promise just in case, as we don't have
      // anything to lose, knowing that we don't have the cache as fallback
      try {
        response = await networkPromise;
      } catch(error) {
        // This might be the same error we got from the promise race
        console.warn(
          `${error} fetching from network ${request.url}`
        );
      }
    } else if (!response) {
      // If we didn't get a response and didn't try the cache, try it now
      // as a fallback
      response = await this.fetchFromCache(request);
    }

    if (response) {
      afterHandlePromise = this.saveToCache(request, response.clone());
    } else {
      afterHandlePromise = Promise.resolve();
    }

    return { response, afterHandlePromise }
  }
}

/**
 * Stale-while-revalidate: try the cache. If it's a hit, return that and
 * go to the network to fetch a new response and store it. If it's a miss,
 * just fall back to network and then store the response.
 */

class StaleWhileRevalidate extends Handler {
  async handle(request) {
    let response = await this.fetchFromCache(request);
    let afterHandlePromise;

    if (response) {
      afterHandlePromise = this.revalidateCache(request);
      return { response, afterHandlePromise }
    }

    console.debug(`Cache miss for ${request.url}`);

    try {
      response = await this.fetchFromNetwork(request);
    } catch(error) {
      console.warn(
        `${error} fetching from network ${request.url}`
      );
    }

    if (response) {
      afterHandlePromise = this.saveToCache(request, response.clone());
    } else {
      afterHandlePromise = Promise.resolve();
    }

    return { response, afterHandlePromise }
  }

  async revalidateCache(request) {
    try {
      const response = await this.fetchFromNetwork(request);
      if (response) {
        await this.saveToCache(request, response.clone());
      }
    } catch(error) {
      console.debug(`${error} revalidating cache for ${request.url}`);
    }
  }
}

const cacheFirst = (config) => new CacheFirst(config);
const networkFirst = (config) => new NetworkFirst(config);
const staleWhileRevalidate = (config) => new StaleWhileRevalidate(config);

var index = /*#__PURE__*/Object.freeze({
  __proto__: null,
  cacheFirst: cacheFirst,
  networkFirst: networkFirst,
  staleWhileRevalidate: staleWhileRevalidate
});

const serviceWorker = new ServiceWorker();

function addRule(rule) {
  serviceWorker.addRule(rule);
}

function start() {
  serviceWorker.start();
}

export { ServiceWorker, addRule, index as handlers, serviceWorker, start };
