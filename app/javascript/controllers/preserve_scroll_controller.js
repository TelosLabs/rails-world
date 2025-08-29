import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect () {
    if (!window.scrollPositions) {
      window.scrollPositions = {}
    }

    window.addEventListener('turbo:before-render', this.preserveScroll)
    window.addEventListener('turbo:render', this.restoreScroll)
    window.addEventListener('turbo:before-fetch-request', this.preserveScroll)
    window.addEventListener('turbo:frame-render', this.restoreScroll)
  }

  disconnect () {
    window.removeEventListener('turbo:before-render', this.preserveScroll)
    window.removeEventListener('turbo:render', this.restoreScroll)
    window.removeEventListener('turbo:before-fetch-request', this.preserveScroll)
    window.removeEventListener('turbo:frame-render', this.restoreScroll)
  }

  preserveScroll () {
    document.querySelectorAll('[data-preserve-scroll]').forEach((element) => {
      window.scrollPositions[element.id] = element.scrollLeft
    })
  }

  restoreScroll () {
    document.querySelectorAll('[data-preserve-scroll]').forEach((element) => {
      element.scrollLeft = window.scrollPositions[element.id]
    })
  }
}
