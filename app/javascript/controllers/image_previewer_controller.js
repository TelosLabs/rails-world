import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['image', 'input', 'hideOnLoad']
  
  connect () {
    this.inputTarget.onchange = evt => {
      
      const [file] = this.inputTarget.files
      if (file) {
        this.imageTarget.src = URL.createObjectURL(file)
        this.imageTarget.style.display = 'block'
        this.imageTarget.style.position = 'absolute'

        this.hideOnLoadTargets.forEach(element => {
          element.style.display = 'none'
        })
      }
    }
  }
}
