/* global Notification */

import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static values = { vapidKey: String, notificationsEnabled: Boolean }
  static targets = ['enableNotifications']

  connect () {
    switch (Notification.permission) {
      case 'denied':
        this.handleDeniedPermission()
        break
      case 'granted':
        this.handleGrantedPermission()
        break
      default:
        this.handlePendingPermission()
        break
    }
  }

  handleDeniedPermission () {
    if (!this.notificationsEnabledValue) return

    this.displayNotificationBlockingMessage()
  }

  handleGrantedPermission () {
    this.setUpSubscription()
    this.removeNotificationBlockingMessage()
  }

  handlePendingPermission () {
    if (this.hasEnableNotificationsTarget) {
      this.handleNotificationToggle()
    }

    if (this.notificationsEnabledValue) {
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
          this.handleGrantedPermission()
        } else if (permission === 'denied') {
          this.displayNotificationBlockingMessage()
        }
      })
      .catch((error) => { console.error(error) })
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

  displayNotificationBlockingMessage () {
    this.toggleNotificationBlockingMessage(true)
  }

  removeNotificationBlockingMessage () {
    this.toggleNotificationBlockingMessage(false)
  }

  toggleNotificationBlockingMessage (show) {
    const message = document.querySelector('.notification-blocking-message')
    if (!message) return

    if (show) {
      message.classList.remove('hidden')
    } else {
      message.classList.add('hidden')
    }
  }
}
