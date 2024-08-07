/* global Notification */

import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static values = { vapidKey: String }
  static targets = ['enableNotifications']

  connect () {
    if (Notification.permission === 'denied') return

    if (Notification.permission === 'granted') {
      this.getSubscription()
    } else {
      this.promptNotificationPermission()
    }
  }

  promptNotificationPermission () {
    this.enableNotificationsTarget.addEventListener('change', (event) => {
      if (!event.target.checked) { return }

      Notification.requestPermission()
        .then((permission) => {
          if (permission === 'granted') {
            this.setupSubscription()
          } else if (permission === 'denied') {
            console.warn('Notifications Denied.')
          }
        })
        .catch((error) => { console.error(error) })
    })
  }

  async setupSubscription () {
    if (!navigator.serviceWorker) {
      console.error('Service workers are not supported by this browser.')
      return
    }

    if (!this.vapidKeyValue) {
      console.error('VAPID key is not available.')
      return
    }

    const vapidKey = new Uint8Array(JSON.parse(this.vapidKeyValue))

    await navigator.serviceWorker.register('/service_worker.js')
    const registration = await navigator.serviceWorker.ready
    const subscription = await registration.pushManager.subscribe({
      userVisibleOnly: true,
      applicationServerKey: vapidKey
    })

    await this.sendSubscriptionToServer(subscription)
  }

  async getSubscription () {
    if (!navigator.serviceWorker) {
      console.error('Service workers are not supported by this browser.')
      return
    }

    if (!this.vapidKeyValue) {
      console.error('VAPID key is not available.')
      return
    }

    const registration = await navigator.serviceWorker.ready
    const subscription = await registration.pushManager.getSubscription()

    await this.sendSubscriptionToServer(subscription)
  }

  async sendSubscriptionToServer (subscription) {
    await fetch('/webpush_subscription', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify(subscription)
    })
  }
}
