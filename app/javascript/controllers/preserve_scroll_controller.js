import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect () {
    if (!window.scrollPositions) {
      window.scrollPositions = {}
    }

    window.addEventListener('turbo:before-render', this.preserveScroll)
    window.addEventListener('turbo:render', this.restoreScroll)
    window.addEventListener('turbo:load', this.restoreBodyScroll)
  }

  preserveScroll () {
    document.querySelectorAll('[data-preserve-scroll]').forEach((element) => {
      window.scrollPositions[element.id] = element.scrollLeft
    })

    // Preserve scroll position of body
    window.scrollPositions.body = {
      scrollTop: window.scrollY
    }
  }

  restoreScroll () {
    document.querySelectorAll('[data-preserve-scroll]').forEach((element) => {
      element.scrollLeft = window.scrollPositions[element.id]
    })
  }

  restoreBodyScroll () {
    const bodyPositions = window.scrollPositions.body

    if (bodyPositions) {
      window.scrollTo(0, bodyPositions.scrollTop)
    }
  }
}
