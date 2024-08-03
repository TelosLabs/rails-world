import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  connect () {
    this.close()
  }

  close (event) {
    setTimeout(() => {
      //Animate element to dissapear towards the right
      this.element.style.transition = 'transform 600ms, opacity 600ms';
      this.element.style.transform = `translate(200px, 0px)`
      this.element.style.opacity = 0
      setTimeout(() => {
        this.element.remove()
      }, 600)
    }, 3000)
  }
}
