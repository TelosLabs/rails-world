// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import '@hotwired/turbo-rails'
import { Turbo } from "@hotwired/turbo-rails"
import 'controllers'
import 'custom/companion'
import 'trix'
import '@rails/actiontext'


Turbo.offline.start("/service-worker.js", {
  scope: "/",
  type: "classic",
  native: true
})
