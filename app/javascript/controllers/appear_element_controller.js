import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  initialize () {
    this.element.classList.add('opacity-0', 'transition', 'ease-in-out')
  }

  connect () {
    this.show()
  }

  show (event) {
    setTimeout(() => {
      this.element.classList.remove('opacity-0')
      this.element.classList.add('opacity-1')
    }, 600)
  }
}
