import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['image', 
                    'input', 
                    'hideOnLoad', 
                    'onRemoveImageTemplate', 
                    'onRemoveImageContainer', 
                    'onRemoveImagePlaceholderTemplate', 
                    'onRemoveImagePlaceholderContainer']

  connect () {
    this.inputTarget.onchange = evt => {
      const [file] = this.inputTarget.files
      if (file) {
        this.imageTarget.src = URL.createObjectURL(file)
        this.imageTarget.style.display = 'block'
        this.imageTarget.style.position = 'absolute'
        this.onRemoveImageContainerTarget.innerHTML = ''
        this.onRemoveImagePlaceholderContainerTarget.innerHTML = ''
        this.hideOnLoadTargets.forEach(element => {
          element.style.display = 'none'
        })
      }
    }
  }

  removeImage(event) {
    this.imageTarget.src = ''
    this.imageTarget.style.display = 'none'
    this.inputTarget.value = ''
    this.onRemoveImageContainerTarget.innerHTML = this.onRemoveImageTemplateTarget.innerHTML
    this.onRemoveImagePlaceholderContainerTarget.innerHTML = this.onRemoveImagePlaceholderTemplateTarget.innerHTML
    this.hideOnLoadTargets.forEach(element => {
      element.style.display = 'none'
    })
  }
}
