/* global self, caches, workbox */
/* eslint-env serviceworker */

importScripts('https://storage.googleapis.com/workbox-cdn/releases/6.4.1/workbox-sw.js')

const { registerRoute, setCatchHandler } = workbox.routing
const { StaleWhileRevalidate, CacheFirst } = workbox.strategies
const { ExpirationPlugin } = workbox.expiration

const META_CACHE   = 'meta-v1'
const PAGES_CACHE  = 'pages-v1'
const ASSETS_CACHE = 'assets-v1'
const IMG_CACHE    = 'img-v1'

const WARM_MARK      = '/__warm__/pages-v1'
const PRECACHE_PATH  = '/service-worker/precache.json'
const OFFLINE_PATH   = '/offline.html'

const ONE_WEEK_S = 7 * 24 * 60 * 60
const IMG_MAX_ENTRIES = 300
const PAGE_WARM_BATCH = 40
const IMG_WARM_BATCH  = 50

workbox.core.clientsClaim()
workbox.core.skipWaiting()

const chunk = (arr, n) =>
  Array.from({ length: Math.ceil(arr.length / n) }, (_, i) => arr.slice(i * n, i * n + n))

const normalizeURL = (urlStr, { dropSearch = false } = {}) => {
  try {
    const u = new URL(urlStr)
    u.hash = ''
    if (dropSearch) u.search = ''
    return u.toString()
  } catch {
    return urlStr
  }
}

const isSameOrigin = (u) => new URL(u, self.location.origin).origin === self.location.origin

const buildRequest = (u) =>
  isSameOrigin(u)
    ? new Request(u, { credentials: 'same-origin' })
    : new Request(u, { mode: 'no-cors' })

const fetchJSON = async (path) => {
  try {
    const res = await fetch(path, { credentials: 'same-origin', headers: { Accept: 'application/json' } })
    if (!res.ok) throw new Error(`HTTP ${res.status}`)
    return await res.json()
  } catch (err) {
    console.error('[SW] JSON fetch error', path, err)
    return null
  }
}

const putInCache = async (cache, req, res) => {
  try { await cache.put(req, res.clone()) } catch (err) { console.error('[SW] cache.put error', req, err) }
}

const matchPageFromCache = async (pagesCache, req) => {
  try {
    const url = new URL(req.url)
    url.hash = ''

    let hit = await pagesCache.match(url.toString())
    if (hit) return hit

    url.search = ''
    hit = await pagesCache.match(url.toString())
    if (hit) return hit
  } catch {}
  return null
}

const hasAnyPagesCached = async () => {
  const cache = await caches.open(PAGES_CACHE)
  const keys  = await cache.keys()
  return keys.length > 0
}

const alreadyWarmed = async () => {
  const cache = await caches.open(META_CACHE)
  const mark  = await cache.match(WARM_MARK)
  if (!mark) return false
  return hasAnyPagesCached()
}
const markWarmed = async () => {
  const cache = await caches.open(META_CACHE)
  await cache.put(WARM_MARK, new Response('ok'))
}

const cacheOfflinePage = async (pagesCache) => {
  try {
    const req = new Request(OFFLINE_PATH, { credentials: 'same-origin' })
    const res = await fetch(req)
    if (res.ok) await putInCache(pagesCache, req, res)
    else console.warn('[SW] offline.html not cached', res.status)
  } catch (err) { console.error('[SW] offline.html fetch error', err) }
}

const warmPagesBatch = async (pages, pagesCache) => {
  await Promise.all(pages.map(async (url) => {
    try {
      const req = new Request(url, { credentials: 'same-origin' })
      const res = await fetch(req)
      if (!res.ok) {
        console.warn('[SW] Page NOT cached (status)', { url, status: res.status })
        return
      }
      const finalURL = normalizeURL(res.url)
      await pagesCache.put(finalURL, res.clone())
      if (finalURL !== url) console.log('[SW] Redirected', { from: url, to: finalURL })
    } catch (error) {
      console.error('[SW] Page fetch error', url, error)
    }
  }))
}

const warmImagesBatch = async (images, imgCache) => {
  await Promise.all(images.map(async (u) => {
    try {
      const req = buildRequest(u)
      const res = await fetch(req)
      if (res.ok || res.type === 'opaque') await imgCache.put(u, res.clone())
    } catch (error) {
      console.error('[SW] Image fetch error', u, error)
    }
  }))
}

const post = async (payload) => {
  const cs = await self.clients.matchAll()
  cs.forEach(c => c.postMessage(payload))
}

const isNavigate = ({ request }) => request.mode === 'navigate'
const isAsset    = ({ request }) => request.destination === 'style' || request.destination === 'script'
const isImage    = ({ request }) => request.destination === 'image'

registerRoute(
  isNavigate,
  new StaleWhileRevalidate({ cacheName: PAGES_CACHE })
)

registerRoute(
  isAsset,
  new StaleWhileRevalidate({ cacheName: ASSETS_CACHE })
)

registerRoute(
  isImage,
  new CacheFirst({
    cacheName: IMG_CACHE,
    plugins: [new ExpirationPlugin({ maxEntries: IMG_MAX_ENTRIES, maxAgeSeconds: ONE_WEEK_S })]
  })
)

setCatchHandler(async ({ event }) => {
  if (event.request.mode !== 'navigate') return Response.error()

  const pagesCache = await caches.open(PAGES_CACHE)
  const hit = await matchPageFromCache(pagesCache, event.request)
  if (hit) return hit

  return pagesCache.match(OFFLINE_PATH)
})

let warming = null

async function warmAllPagesAndAPIs () {
  if (await alreadyWarmed()) {
    console.log('[SW] Skipping warmup: already warmed and pages present.')
    return
  }
  if (warming) return warming

  warming = (async () => {
    const precache = await fetchJSON(PRECACHE_PATH)
    const pages  = precache?.pages  ?? []
    const images = precache?.images ?? []

    console.log('[SW] precache pages:', pages)
    console.log('[SW] precache images:', images)

    const pagesCache = await caches.open(PAGES_CACHE)
    const imgCache   = await caches.open(IMG_CACHE)

    await cacheOfflinePage(pagesCache)

    for (const batch of chunk(pages, PAGE_WARM_BATCH)) {
      await warmPagesBatch(batch, pagesCache)
    }

    for (const batch of chunk(images, IMG_WARM_BATCH)) {
      await warmImagesBatch(batch, imgCache)
    }

    const keys = (await pagesCache.keys()).map(key => key.url)
    console.log('[SW] Cached page keys:', keys)

    if (await hasAnyPagesCached()) {
      await markWarmed()
      console.log('[SW] Warmup complete.')
    } else {
      console.warn('[SW] Warmup finished but no pages were cached.')
    }
  })()

  return warming
}

self.addEventListener('activate', (event) => {
  event.waitUntil((async () => {
    await warmAllPagesAndAPIs()
    await post({ type: 'warm-complete' })
  })())
})

self.addEventListener('message', (event) => {
  if (event.data?.type === 'warm-all') {
    warmAllPagesAndAPIs()
      .then(() => post({ type: 'warm-complete' }))
      .catch(() => post({ type: 'warm-failed' }))
  }
})
