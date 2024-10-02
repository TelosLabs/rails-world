import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static values = {
    location: String
  }

  connect () {
    this.targetElement.scrollIntoView()
    this.element.remove()
  }

  get targetElement () {
    return document.getElementById(this.locationValue)
  }
}
