import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['banner']

  connect () {
    this.handleOnlineStatus = this.handleOnlineStatus.bind(this)

    window.addEventListener('online', this.handleOnlineStatus)
    window.addEventListener('offline', this.handleOnlineStatus)

    this.handleOnlineStatus()
  }

  disconnect () {
    window.removeEventListener('online', this.handleOnlineStatus)
    window.removeEventListener('offline', this.handleOnlineStatus)
  }

  handleOnlineStatus () {
    if (navigator.onLine) {
      this.hideBanner()
    } else {
      this.showBanner()
    }
  }

  showBanner () {
    this.bannerTarget.classList.remove('hidden', '-translate-y-full')
    this.bannerTarget.classList.add('translate-y-0')
  }

  hideBanner () {
    this.bannerTarget.classList.remove('translate-y-0')
    this.bannerTarget.classList.add('-translate-y-full')

    setTimeout(() => {
      if (navigator.onLine) {
        this.bannerTarget.classList.add('hidden')
      }
    }, 300)
  }

  dismiss () {
    this.hideBanner()
  }
}
