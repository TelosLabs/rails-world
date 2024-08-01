import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['form']
  
  connect () {
  }

  submit(event){
    event.preventDefault()
    this.formTarget.requestSubmit()
  }
}
