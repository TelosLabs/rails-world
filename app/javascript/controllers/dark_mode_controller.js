import { Controller } from '@hotwired/stimulus'
import { getCookie, setCookie } from 'utils/cookies'

export default class extends Controller {
  static targets = ['select']

  connect () {
    this.initializeTheme()
    this.setupSystemThemeListener()
  }

  disconnect () {
    window.matchMedia('(prefers-color-scheme: dark)').removeEventListener('change', this.onSystemChange.bind(this))
  }

  initializeTheme () {
    const currentTheme = this.getCurrentTheme()
    if (this.hasSelectTarget) {
      this.selectTarget.value = currentTheme
    }

    if (currentTheme !== 'system') {
      this.applyTheme(currentTheme)
    }
  }

  getCurrentTheme () {
    const savedTheme = getCookie('theme')

    if (savedTheme) {
      return savedTheme
    }

    return 'system'
  }

  setupSystemThemeListener () {
    if (!window.matchMedia) return
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', this.onSystemChange.bind(this))
  }

  onSystemChange () {
    if (this.getCurrentTheme() === 'system') {
      this.applyTheme('system')
    }
  }

  change () {
    const theme = this.selectTarget.value

    this.applyTheme(theme)
    setCookie('theme', theme)
  }

  applyTheme (mode) {
    let isDark = false

    if (mode === 'dark') {
      isDark = true
    } else if (mode === 'light') {
      isDark = false
    } else if (mode === 'system') {
      isDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches
    }

    document.documentElement.classList.toggle('dark', isDark)
  }
}
