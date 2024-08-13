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
    icon: data.icon
  }

  event.waitUntil(
    self.registration.showNotification(title, options)
  )
})
