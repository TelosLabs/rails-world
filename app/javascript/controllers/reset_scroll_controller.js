import { Controller } from '@hotwired/stimulus'

export default class extends Controller {

  connect () {
    document.addEventListener('turbo:load', this.handleRender)
  }

  disconnect () {
    document.removeEventListener('turbo:load', this.handleRender)
  }

  handleRender () {
    window.scrollTo({ top: 0, left: 0, behavior: 'auto' })
  }
}