/* global localStorage */
import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['select']

  connect () {
    this.mediaQueryList = window.matchMedia('(prefers-color-scheme: dark)')

    this.mediaQueryList.addEventListener('change', this.onSystemChange.bind(this))
    this.applyTheme(localStorage.getItem('theme') ?? 'system')
  }

  disconnect () {
    this.mediaQueryList?.removeEventListener('change', this.onSystemChange.bind(this))
  }

  onSystemChange () {
    this.currentMode === 'system' && this.applyTheme('system')
  }

  change () {
    this.applyTheme(this.selectTarget.value)
  }

  applyTheme (mode) {
    this.currentMode = mode
    const isDark = mode === 'dark' || (mode === 'system' && this.mediaQueryList.matches)

    document.documentElement.classList.toggle('dark', isDark)
    mode === 'system' ? localStorage.removeItem('theme') : localStorage.setItem('theme', mode)
    if (this.hasSelectTarget) this.selectTarget.value = this.currentMode
  }
}
