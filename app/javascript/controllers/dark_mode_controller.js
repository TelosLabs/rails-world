import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['select']

  connect () {
    if (this.hasSelectTarget) {
      this.selectTarget.value = document.documentElement.classList.contains('dark') ? 'dark' : 'light'
    }
  }

  change () {
    const theme = this.selectTarget.value
    this.applyTheme(theme)
    this.setCookie('theme', theme)
  }

  applyTheme (mode) {
    const isDark = mode === 'dark'
    document.documentElement.classList.toggle('dark', isDark)
  }

  setCookie (name, value) {
    const date = new Date()
    date.setTime(date.getTime() + (365 * 24 * 60 * 60 * 1000))
    document.cookie = `${name}=${value}; expires=${date.toUTCString()}; path=/; SameSite=Lax`
  }
}
