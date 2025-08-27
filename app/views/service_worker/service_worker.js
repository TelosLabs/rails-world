/* global self, caches, workbox */
/* eslint-env serviceworker */

importScripts('https://storage.googleapis.com/workbox-cdn/releases/6.4.1/workbox-sw.js')

const { registerRoute, setCatchHandler } = workbox.routing
const { StaleWhileRevalidate, CacheFirst } = workbox.strategies
const { ExpirationPlugin } = workbox.expiration

const META_CACHE = 'meta-v1'
const WARM_MARK = '/__warm__/pages-v1'
const PAGES_CACHE = 'pages-v1'
const ASSETS_CACHE = 'assets-v1'
const IMG_CACHE    = 'img-v1'

workbox.core.clientsClaim()
workbox.core.skipWaiting()

self.addEventListener('install', (event) => {
  event.waitUntil((async () => {
    try {
      await warmAllPagesAndAPIs()
    } catch (e) {
      console.error('[SW] install warm error', e)
    }
  })())
})

const isHTML = (req) => {
  const accept = req.headers.get('Accept') || ''
  return accept.includes('text/html') || accept.includes('vnd.turbo-stream.html')
}

registerRoute(
  ({ request }) =>
    request.mode === 'navigate' ||
    request.destination === 'document' ||
    (request.destination === '' && isHTML(request)),
    new StaleWhileRevalidate({ cacheName: PAGES_CACHE })
)

registerRoute(
  ({ request }) => request.destination === 'style' || request.destination === 'script',
  new StaleWhileRevalidate({ cacheName: ASSETS_CACHE })
)

registerRoute(
  ({ request }) => request.destination === 'image',
  new CacheFirst({
    cacheName: IMG_CACHE,
    plugins: [new ExpirationPlugin({ maxEntries: 300, maxAgeSeconds: 7 * 24 * 60 * 60 })]
  })
)

setCatchHandler(async ({ event }) => {
  if (event.request.mode !== 'navigate') return Response.error()

  const pagesCache = await caches.open(PAGES_CACHE)

  try {
    const u = new URL(event.request.url)
    u.hash = ''
    let res = await pagesCache.match(u.toString())
    if (res) return res

    u.search = ''
    res = await pagesCache.match(u.toString())
    if (res) return res
  } catch (_) {}

  return caches.match('/offline.html')
})


const chunk = (arr, n = 50) => Array.from({ length: Math.ceil(arr.length / n) }, (_, i) => arr.slice(i * n, i * n + n))

self.addEventListener('activate', (event) => {
  event.waitUntil((async () => {
    await warmAllPagesAndAPIs()
    post({ type: 'warm-complete' })
  })())
})

self.addEventListener('message', (e) => {
  if (e.data?.type === 'warm-all') {
    warmAllPagesAndAPIs()
      .then(() => post({ type: 'warm-complete' }))
      .catch(() => post({ type: 'warm-failed' }))
  }
})

async function hasAnyPagesCached () {
  const c = await caches.open(PAGES_CACHE)
  const keys = await c.keys()
  return keys.length > 0
}

async function alreadyWarmed () {
  const c = await caches.open(META_CACHE)
  const mark = await c.match(WARM_MARK)
  if (!mark) return false

  return await hasAnyPagesCached()
}

async function markWarmed () {
  const c = await caches.open(META_CACHE)
  await c.put(WARM_MARK, new Response('ok'))
}

let warming = null

async function warmAllPagesAndAPIs () {
  if (await alreadyWarmed()) {
    console.log('[SW] Skipping warmup: already warmed and pages present.')
    return
  }
  if (warming) return warming

  warming = (async () => {
    let pages = [], images = []
    try {
      const r = await fetch('/service-worker/precache.json', {
        credentials: 'same-origin',
        headers: { Accept: 'application/json' }
      })
      if (!r.ok) {
        console.error('[SW] precache.json failed', r.status)
      } else {
        ({ pages = [], images = [] } = await r.json())
      }
    } catch (e) {
      console.error('[SW] precache.json fetch error', e)
    }

    console.log('[SW] precache pages:', pages)
    console.log('[SW] precache images:', images)

    const pagesCache = await caches.open(PAGES_CACHE)

    try {
      const offReq = new Request('/offline.html', { credentials: 'same-origin' })
      const offRes = await fetch(offReq)
      if (offRes.ok) {
        await pagesCache.put(offReq, offRes.clone())
      } else {
        console.warn('[SW] offline.html not cached', offRes.status)
      }
    } catch (e) { console.error('[SW] offline.html fetch error', e) }

    for (const batch of chunk(pages, 40)) {
      await Promise.all(batch.map(async (url) => {
        try {
          const req = new Request(url, { credentials: 'same-origin' })
          const res = await fetch(req)
          if (!res.ok) {
            console.warn('[SW] Page NOT cached (status)', { url, status: res.status })
            return
          }
          let finalURL
          try {
            const u = new URL(res.url)
            u.hash = ''
            finalURL = u.toString()
          } catch (_) { finalURL = url }
          await pagesCache.put(new Request(finalURL, { credentials: 'same-origin' }), res.clone())
          if (finalURL !== url) console.log('[SW] Redirected', { from: url, to: finalURL })
        } catch (e) {
          console.error('[SW] Page fetch error', url, e)
        }
      }))
    }

    const imgCache = await caches.open(IMG_CACHE)
    for (const batch of chunk(images, 50)) {
      await Promise.all(batch.map(async (u) => {
        try {
          const sameOrigin = new URL(u, self.location.origin).origin === self.location.origin
          const req = sameOrigin ? new Request(u, { credentials: 'same-origin' }) : new Request(u, { mode: 'no-cors' })
          const res = await fetch(req)
          await imgCache.put(req, res.clone())
        } catch (e) {
          console.error('[SW] Image fetch error', u, e)
        }
      }))
    }

    const keys = (await pagesCache.keys()).map(k => k.url)
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


async function post (payload) {
  const cs = await self.clients.matchAll()
  cs.forEach(c => c.postMessage(payload))
}
