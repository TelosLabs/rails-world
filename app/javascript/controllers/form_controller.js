import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['form']

  submit (event) {
    this.formTarget.requestSubmit()
  }
}
