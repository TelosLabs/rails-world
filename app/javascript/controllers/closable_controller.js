import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect () {
    this.close()
  }

  close (event) {
    setTimeout(() => {
      this.element.classList.add('opacity-0')
      setTimeout(() => {
        this.element.remove()
      }, 300)
    }, 3000)
  }
}
