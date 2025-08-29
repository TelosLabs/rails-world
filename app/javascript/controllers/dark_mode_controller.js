import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['select']

  connect () {
    this.initializeTheme()
    this.setupSystemThemeListener()
  }

  initializeTheme () {
    const currentTheme = this.getCurrentTheme()
    if (this.hasSelectTarget) {
      this.selectTarget.value = currentTheme
    }

    // Only apply theme if it's not system or if system theme isn't already applied correctly
    if (currentTheme !== 'system') {
      this.applyTheme(currentTheme)
    } else {
      // For system theme, verify it's correctly applied
      const systemPrefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches
      const isDarkApplied = document.documentElement.classList.contains('dark')

      // Only adjust if there's a mismatch
      if (systemPrefersDark !== isDarkApplied) {
        this.applyTheme('system')
      }
    }
  }

  getCurrentTheme () {
    const savedTheme = this.getCookie('theme')

    if (savedTheme) {
      return savedTheme
    }

    return 'system'
  }

  setupSystemThemeListener () {
    if (window.matchMedia) {
      const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)')
      mediaQuery.addEventListener('change', () => {
        if (this.getCurrentTheme() === 'system') {
          this.applyTheme('system')
        }
      })
    }
  }

  change () {
    const theme = this.selectTarget.value

    this.applyTheme(theme)
    this.setCookie('theme', theme)
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

  getCookie (name) {
    const nameEQ = name + '='
    const ca = document.cookie.split(';')
    for (let i = 0; i < ca.length; i++) {
      let c = ca[i]
      while (c.charAt(0) === ' ') c = c.substring(1, c.length)
      if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length)
    }
    return null
  }

  setCookie (name, value) {
    const date = new Date()
    date.setTime(date.getTime() + (365 * 24 * 60 * 60 * 1000))
    document.cookie = `${name}=${value}; expires=${date.toUTCString()}; path=/; SameSite=Lax`
  }
}
