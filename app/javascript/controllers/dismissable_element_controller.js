import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['element']
  connect () {
    console.log(this.isMobileDevice())
    if (this.isMobileDevice()) {
      this.elementTarget.addEventListener('touchstart', this.onMouseDownTouch.bind(this))
      window.addEventListener('touchend', this.onMouseUpTouch.bind(this))
      window.addEventListener('touchmove', this.onMouseMoveTouch.bind(this))
    } else {
      this.elementTarget.addEventListener('mousedown', this.onMouseDown.bind(this))
      window.addEventListener('mouseup', this.onMouseUp.bind(this))
      window.addEventListener('mousemove', this.onMouseMove.bind(this))
    }
  }

  disconnect () {
    this.removeEventListeners()
  }

  removeEventListeners () {
    if (this.isMobileDevice()) {
      if (this.hasElementTarget) {
        this.elementTarget.removeEventListener('touchstart', this.onMouseDownTouch.bind(this))
      }
      window.addEventListener('touchend', this.onMouseUpTouch.bind(this))
      window.addEventListener('touchmove', this.onMouseMoveTouch.bind(this))
    } else {
      if (this.hasElementTarget) {
        this.elementTarget.removeEventListener('mousedown', this.onMouseDown.bind(this))
      }
      window.removeEventListener('mouseup', this.onMouseUp.bind(this))
      window.removeEventListener('mousemove', this.onMouseMove.bind(this))
    }
  }

  onMouseDown (event) {
    if (!this._active) {
      this._startPos = { x: event.clientX, y: event.clientY }
      this._active = true
    }
  }

  onMouseDownTouch (event) {
    if (!this._active) {
      const clientX = event.touches[0].clientX
      const clientY = event.touches[0].clientY
      this._startPos = { x: clientX, y: clientY }
      this._active = true
    }
  }

  onMouseUp (event) {
    this._active = false
    this.updateElementToFinalTransitionIfPassedThreshold(
      this._startPos.x,
      this._startPos.y,
      event.clientX,
      event.clientY)
  }

  onMouseUpTouch (event) {
    this._active = false

    const clientX = event.changedTouches[0].clientX
    const clientY = event.changedTouches[0].clientY

    this.updateElementToFinalTransitionIfPassedThreshold(
      this._startPos.x,
      this._startPos.y,
      clientX,
      clientY
    )
  }

  onMouseMove (event) {
    if (!this._active) return

    this.updateElementPositionAndOpacityUpToThreshold(
      this._startPos.x,
      this._startPos.y,
      event.clientX,
      event.clientY
    )
  }

  onMouseMoveTouch (event) {
    if (!this._active) return

    const clientX = event.touches[0].clientX
    const clientY = event.touches[0].clientY

    this.updateElementPositionAndOpacityUpToThreshold(
      this._startPos.x,
      this._startPos.y,
      clientX,
      clientY
    )
  }

  updateElementToFinalTransitionIfPassedThreshold (initialPosX, initialPosY, finalPosX, finalPosY) {
    const dx = finalPosX - initialPosX
    const dy = finalPosY - initialPosY

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
        this.removeEventListeners()
      }, 500)
    }
  }

  updateElementPositionAndOpacityUpToThreshold (initialPosX, initialPosY, clientX, clientY) {
    const dx = clientX - initialPosX
    const dy = clientY - initialPosY
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

  isMobileDevice () {
    return /mobile/i.test(navigator.userAgent)
  }
}
