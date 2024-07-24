import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['button']

  async share(event) {
    const url = event.params.url;

    if (!navigator.share) {
      window.open(url);
      return;
    }

    try {
      const blob = (await fetch(url)).blob();
      const file = new File([blob], 'qr.png', { type: 'image/png' });

      await navigator.share({
        files: [file],
        title: 'QR Code'
      });
    } catch (err) {
      window.open(url);
    }
  }
}
