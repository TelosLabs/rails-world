/* global self, clients, importScripts, workbox */

importScripts(
  'https://storage.googleapis.com/workbox-cdn/releases/6.4.1/workbox-sw.js'
)

// ------------- Push Notifications -------------

self.addEventListener('push', async (event) => {
  let data
  try {
    data = await event.data.json()
  } catch (e) {
    data = { title: event.data.text(), body: event.data.text(), icon: 'pwa_home_screen_icon.png' }
  }

  const title = data.title
  const options = {
    body: data.body,
    icon: data.icon,
    data
  }

  event.waitUntil(
    self.registration.showNotification(title, options)
  )
})

self.addEventListener('notificationclick', function (event) {
  event.notification.close()
  if (!event.notification.data.path) return

  event.waitUntil(
    clients.matchAll({ type: 'window' }).then((clientList) => {
      for (let i = 0; i < clientList.length; i++) {
        const client = clientList[i]
        const clientPath = (new URL(client.url)).pathname

        if (clientPath === event.notification.data.path && 'focus' in client) {
          return client.focus()
        }
      }

      if (clients.openWindow) {
        return clients.openWindow(event.notification.data.path)
      }
    })
  )
})

// ------------- Request handling -------------

const { CacheFirst, NetworkFirst } = workbox.strategies
const { registerRoute } = workbox.routing

// For assets (scripts and images), cache first
registerRoute(
  ({ request }) => request.destination === 'script' ||
  request.destination === 'style',
  new CacheFirst({
    cacheName: 'assets-styles-and-scripts'
  })
)

registerRoute(
  ({ request }) => request.destination === 'image',
  new CacheFirst({
    cacheName: 'assets-images'
  })
)

// For pages, network first
registerRoute(
  ({ request, url }) => request.destination === 'document' ||
                      request.destination === '',
  new NetworkFirst()
)

// Offline fallback

const { warmStrategyCache } = workbox.recipes
const { setCatchHandler } = workbox.routing
const strategy = new NetworkFirst()
const urls = ['/offline.html']

// Warm the runtime cache with a list of asset URLs
warmStrategyCache({ urls, strategy })

// Trigger a 'catch' handler when any of the other routes fail to generate a response
setCatchHandler(async ({ event }) => {
  switch (event.request.destination) {
    case 'document':
      return strategy.handle({ event, request: urls[0] })
    default:
      return Response.error()
  }
})
