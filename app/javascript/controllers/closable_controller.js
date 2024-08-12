import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  initialize () {
    this._closeTimeout = null
  }
  
  connect () {
    this.close()
  }

  cancelClose () {
    if(this._closeTimeout){
      clearTimeout(this._closeTimeout)
      this._closeTimeout = null
    }
  }

  close (event) {
    if(this._closeTimeout == null){
      this._closeTimeout = setTimeout(() => {
        // Animate element to disappear towards the right
        this.element.style.transition = 'transform 600ms, opacity 600ms'
        this.element.style.transform = 'translate(200px, 0px)'
        this.element.style.opacity = 0
        setTimeout(() => {
          this.element.remove()
        }, 600)
      }, 3000)
    }
  }
}
