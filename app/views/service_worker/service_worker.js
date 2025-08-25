/* global self, caches, workbox */
/* eslint-env serviceworker */

importScripts('https://storage.googleapis.com/workbox-cdn/releases/6.4.1/workbox-sw.js')

const { registerRoute, setCatchHandler } = workbox.routing
const { StaleWhileRevalidate, CacheFirst } = workbox.strategies
const { ExpirationPlugin } = workbox.expiration

workbox.core.clientsClaim()
workbox.core.skipWaiting()

const isHTML = (req) => {
  const accept = req.headers.get('Accept') || ''
  return accept.includes('text/html') || accept.includes('vnd.turbo-stream.html')
}

const ignoreSearchPlugin = {
  cacheKeyWillBeUsed: async ({ request }) => {
    const url = new URL(request.url)
    url.search = ''
    url.hash = ''
    return new Request(url.toString(), { credentials: 'same-origin' })
  }
}

registerRoute(
  ({ request }) =>
    request.mode === 'navigate' ||
    request.destination === 'document' ||
    (request.destination === '' && isHTML(request)),
  new StaleWhileRevalidate({ cacheName: 'pages-v1', plugins: [ignoreSearchPlugin] })
)

registerRoute(
  ({ request }) => request.destination === 'style' || request.destination === 'script',
  new StaleWhileRevalidate({ cacheName: 'assets-v1' })
)

registerRoute(
  ({ request }) => request.destination === 'image',
  new CacheFirst({
    cacheName: 'img-v1',
    plugins: [new ExpirationPlugin({ maxEntries: 300, maxAgeSeconds: 7 * 24 * 60 * 60 })]
  })
)

setCatchHandler(async ({ event }) => {
  if (event.request.mode === 'navigate') return caches.match('/offline.html')
  return Response.error()
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

const META_CACHE = 'meta-v1'
const WARM_MARK = '/__warm__/pages-v1'

async function alreadyWarmed () {
  const c = await caches.open(META_CACHE)
  return !!(await c.match(WARM_MARK))
}
async function markWarmed () {
  const c = await caches.open(META_CACHE)
  await c.put(WARM_MARK, new Response('ok'))
}

let warming = null

async function warmAllPagesAndAPIs () {
  if (await alreadyWarmed()) return
  if (warming) return warming

  warming = (async () => {
    const { pages, images } = await fetch('/service-worker/precache.json', {
      credentials: 'same-origin',
      headers: { Accept: 'application/json' }
    }).then(r => r.ok ? r.json() : ({ pages: [], images: [] })).catch(() => ({ pages: [], images: [] }))

    const pagesCache = await caches.open('pages-v1')

    try {
      const offReq = new Request('/offline.html', { credentials: 'same-origin' })
      const offRes = await fetch(offReq)
      if (offRes.ok) await pagesCache.put(offReq, offRes.clone())
    } catch (_) {}

    for (const batch of chunk(pages, 40)) {
      await Promise.all(batch.map(async (url) => {
        try {
          const req = new Request(url, { credentials: 'same-origin' })
          const res = await fetch(req)

          if (!res.ok) {
            console.error('[SW] Page NOT cached (status)', { url, status: res.status })
            return
          }

          let finalPath
          try { finalPath = new URL(res.url).pathname } catch (_) { finalPath = url }

          const finalReq = new Request(finalPath, { credentials: 'same-origin' })
          await pagesCache.put(finalReq, res.clone())

          const samePath = finalPath === url
          if (!samePath) console.log('[SW] Redirected', { from: url, to: finalPath })

        } catch (e) { }
      }))
    }

    const imgCache = await caches.open('img-v1')
    for (const batch of chunk(images, 50)) {
      await Promise.all(batch.map(async (u) => {
        try {
          const sameOrigin = new URL(u, self.location.origin).origin === self.location.origin
          const req = sameOrigin ? new Request(u, { credentials: 'same-origin' }) : new Request(u, { mode: 'no-cors' })
          const res = await fetch(req)
          await imgCache.put(req, res.clone())
        } catch (e) { }
      }))
    }
    await markWarmed()
  })()
  return warming
}

async function post (payload) {
  const cs = await self.clients.matchAll()
  cs.forEach(c => c.postMessage(payload))
}
