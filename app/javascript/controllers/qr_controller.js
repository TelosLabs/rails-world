import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['button']

  async share () {
    const button = this.buttonTarget

    if (navigator.share) {
      try {
        const file = await fetch(button.dataset.url)
          .then((response) => response.blob())
          .then((blob) => new File([blob], 'qr.png', { type: 'image/png' }))

        await navigator.share({
          files: [file], title: 'QR Code'
        })
      } catch (err) {
        window.open(button.dataset.url)
      }
    } else {
      window.open(button.dataset.url)
    }
  }
}
