import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ["installBtn"];

  connect () {
    this.installPrompt = null;

    if (this.hasInstallBtnTarget) {
      this.setupInstallPrompt();
      this.setupAppInstalledListener();
    }
  }

  setupInstallPrompt() {
    window.addEventListener("beforeinstallprompt", (event) => {
      event.preventDefault();

      this.installPrompt = event;
      this.installBtnTarget.removeAttribute("hidden");
    });

    this.installBtnTarget.addEventListener("click", async () => {
      if (!this.installPrompt) { return }

      await this.installPrompt.prompt();
      this.disableInAppInstallPrompt();
    });
  }

  setupAppInstalledListener() {
    window.addEventListener("appinstalled", () => {
      this.disableInAppInstallPrompt();
    });
  }

  disableInAppInstallPrompt() {
    this.installPrompt = null;
    this.installBtnTarget.setAttribute("hidden", "");
  }
}