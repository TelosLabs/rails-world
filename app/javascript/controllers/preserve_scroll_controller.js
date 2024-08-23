import { Controller } from '@hotwired/stimulus'

export default class extends Controller {

  connect() {
    if (!window.scrollPositions) {
      window.scrollPositions = {};
    }

    window.addEventListener("turbo:before-render", this.preserveScroll)
    window.addEventListener("turbo:render", this.restoreScroll)
  }

  preserveScroll () {
    document.querySelectorAll("[data-preserve-scroll]").forEach((element) => {
      scrollPositions[element.id] = element.scrollLeft;
    })
  }

  restoreScroll () {
    document.querySelectorAll("[data-preserve-scroll]").forEach((element) => {
      element.scrollLeft = scrollPositions[element.id];
    })
  }
}
