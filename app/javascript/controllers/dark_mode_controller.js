import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['switch']

  connect () {
    const isDark = localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)

    document.documentElement.classList.toggle('dark', isDark)
    this.updateSwitch(isDark)
  }

  toggle () {
    const enableDark = !document.documentElement.classList.contains('dark')
    document.documentElement.classList.toggle('dark', enableDark)
    localStorage.theme = enableDark ? 'dark' : 'light'
    this.updateSwitch(enableDark)
  }

  updateSwitch (isDark) {
    const ball = this.switchTarget.querySelector('span:last-child')
    if (isDark) {
      ball.classList.add('dark:translate-x-6')
    } else {
      ball.classList.remove('dark:translate-x-6')
    }
  }
}
