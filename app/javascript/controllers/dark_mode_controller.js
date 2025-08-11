/* global localStorage */
import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['select']

  connect () {
    this.mql = window.matchMedia('(prefers-color-scheme: dark)')
    this.mql.addEventListener('change', (this.onSystemChange = () => this.current === 'system' && this.applyTheme('system')))
    this.applyTheme(localStorage.getItem('theme') ?? 'system')
  }

  disconnect () {
    this.mql?.removeEventListener('change', this.onSystemChange)
  }

  change () {
    this.applyTheme(this.selectTarget.value)
  }

  applyTheme (mode) {
    this.current = mode
    const isDark = mode === 'dark' || (mode === 'system' && this.mql.matches)
    document.documentElement.classList.toggle('dark', isDark)
    mode === 'system' ? localStorage.removeItem('theme') : localStorage.setItem('theme', mode)
    if (this.hasSelectTarget) this.selectTarget.value = this.current
  }
}
