/* global self */

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
    data: data
  }

  event.waitUntil(
    self.registration.showNotification(title, options)
  )
})

self.addEventListener("notificationclick", function(event) {
  event.notification.close()
  if (!event.notification.data.path) return

  event.waitUntil(
    clients.matchAll({ type: "window" }).then((clientList) => {
      for (let i = 0; i < clientList.length; i++) {
        let client = clientList[i]
        let clientPath = (new URL(client.url)).pathname

        if (clientPath == event.notification.data.path && "focus" in client) {
          return client.focus()
        }
      }

      if (clients.openWindow) {
        return clients.openWindow(event.notification.data.path)
      }
    })
  )
})
