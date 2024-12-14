# Pin npm packages by running ./bin/importmap
# config/importmap.rb

# Pin application.js
pin 'application', to: 'application.js'

# Pin npm packages
pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'

# Pin all controllers (from app/javascript/controllers/)
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin "@nathanvda/cocoon", to: "https://cdn.jsdelivr.net/npm/@nathanvda/cocoon@1.2.14/cocoon.min.js"
pin "jquery", to: "https://code.jquery.com/jquery-3.6.0.min.js"

# Pin dark_mode_toggle.js
pin "dark_mode_toggle", to: "dark_mode_toggle.js"
pin 'dropdown_toggle', to: 'dropdown_toggle.js'
