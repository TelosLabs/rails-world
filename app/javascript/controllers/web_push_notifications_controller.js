/* global Notification */

import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static values = { vapidKey: String, inAppNotifications: Boolean }
  static targets = ['enableNotifications']

  connect () {
    switch (Notification.permission) {
      case 'denied':
        this.handleDeniedPermission()
        break
      case 'granted':
        this.setUpSubscription()
        break
      default:
        this.handleDefaultPermission()
        break
    }
  }

  handleDeniedPermission () {
    if (!this.inAppNotificationsValue) return

    this.displayNotificationBlockingMessage()
  }

  handleDefaultPermission () {
    if (this.hasEnableNotificationsTarget) {
      this.handleNotificationToggle()
    } else if (this.inAppNotificationsValue) {
      this.promptNotificationPermission()
    }
  }

  handleNotificationToggle () {
    this.enableNotificationsTarget.addEventListener('change', (event) => {
      if (!event.target.checked) { return }

      this.promptNotificationPermission()
    })
  }

  promptNotificationPermission () {
    Notification.requestPermission()
      .then((permission) => {
        if (permission === 'granted') {
          this.setUpSubscription()
        } else if (permission === 'denied') {
          this.displayNotificationBlockingMessage()
        }
      })
      .catch((error) => { console.error(error) })
  }

  displayNotificationBlockingMessage () {
    const notificationBlockingMessage = document.getElementById('notification_blocking_message')
    if (!notificationBlockingMessage) return

    notificationBlockingMessage.classList.remove('hidden')
  }

  async setUpSubscription () {
    if (!navigator.serviceWorker) {
      console.error('Service workers are not supported by this browser.')
      return
    }

    if (!this.vapidKeyValue) {
      console.error('VAPID key is not available.')
      return
    }

    await navigator.serviceWorker.register('/service_worker.js')
    const registration = await navigator.serviceWorker.ready
    let subscription = await registration.pushManager.getSubscription()

    if (!subscription) {
      const vapidKey = new Uint8Array(JSON.parse(this.vapidKeyValue))

      subscription = await registration.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: vapidKey
      })
    }

    await this.sendSubscriptionToServer(subscription)
  }

  async sendSubscriptionToServer (subscription) {
    await fetch('/web_push_subscriptions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify(subscription)
    })
  }
}
