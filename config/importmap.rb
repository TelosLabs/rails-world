# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@stimulus-components/dropdown", to: "@stimulus-components--dropdown.js" # @3.0.0
pin "stimulus-use" # @0.52.2
pin_all_from "app/javascript/custom", under: "custom"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "@stimulus-components/password-visibility", to: "@stimulus-components--password-visibility.js" # @3.0.0
pin_all_from "app/javascript/pwa", under: "pwa"
