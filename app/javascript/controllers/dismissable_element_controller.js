import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['element']
  connect () {
    this.elementTarget.addEventListener('mousedown', this.onMouseDown.bind(this))
    window.addEventListener('mouseup', this.onMouseUp.bind(this))
    window.addEventListener('mousemove', this.onMouseMove.bind(this))
  }

  disconnect () {
    if (this.hasElementTarget) {
      this.elementTarget.removeEventListener('mousedown', this.onMouseDown.bind(this))
    }
    window.removeEventListener('mouseup', this.onMouseUp.bind(this))
    window.removeEventListener('mousemove', this.onMouseMove.bind(this))
  }

  onMouseDown (event) {
    if (!this._active) {
      this._startPos = { x: event.clientX, y: event.clientY }
      this._active = true
      this._scheduledAnimationFrame = false
    }
  }

  onMouseUp (event) {
    this._active = false

    const dx = event.clientX - this._startPos.x
    const dy = event.clientY - this._startPos.y

    const horizontalDir = Math.abs(dx) > Math.abs(dy)
    const horizontalThreshold = 120
    const verticalThreshold = 40
    let translateX = 0
    let translateY = 0
    let opacity = 1

    if (horizontalDir) {
      if (Math.abs(dx) > horizontalThreshold) {
        translateX = Math.sign(dx) * horizontalThreshold * 2
        opacity = 0
      }
    } else {
      if (Math.abs(dy) > verticalThreshold) {
        translateY = Math.sign(dy) * verticalThreshold * 2
        opacity = 0
      }
    }
    this.elementTarget.style.transform = `translate(${translateX}px, ${translateY}px)`
    this.elementTarget.style.opacity = opacity
    if (opacity === 0) {
      setTimeout(() => {
        this.elementTarget.remove()
        window.removeEventListener('mouseup', this.onMouseUp.bind(this))
        window.removeEventListener('mousemove', this.onMouseMove.bind(this))
      }, 500)
    }
  }

  onMouseMove (event) {
    if (!this._active) return

    const dx = event.clientX - this._startPos.x
    const dy = event.clientY - this._startPos.y

    const horizontalDir = Math.abs(dx) > Math.abs(dy)
    const horizontalThreshold = 120
    const verticalThreshold = 40
    const opacityThreshold = 0.4

    let translateX = 0
    let translateY = 0
    let opacity = 1

    if (horizontalDir) {
      if (Math.abs(dx) > horizontalThreshold) {
        translateX = horizontalThreshold * Math.sign(dx)
        opacity = opacityThreshold
      } else {
        translateX = dx
        opacity = 1 - (opacityThreshold * Math.abs(dx)) / horizontalThreshold
      }
    } else {
      if (Math.abs(dy) > verticalThreshold) {
        translateY = verticalThreshold * Math.sign(dy)
        opacity = opacityThreshold
      } else {
        translateY = dy
        opacity = 1 - (opacityThreshold * Math.abs(dy)) / verticalThreshold
      }
    }

    this.elementTarget.style.transform = `translate(${translateX}px, ${translateY}px)`
    this.elementTarget.style.opacity = opacity
  }
}
