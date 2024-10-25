source "https://rubygems.org"

ruby "3.3.3" unless RUBY_PLATFORM =~ /wasm/

gem "rails", "~> 7.2", group: [:default, :wasm]

# Database
gem "activerecord-enhancedsqlite3-adapter", "~> 0.8.0"
gem "sqlite3", "~> 1.4", group: [:default, :wasm]

# Jobs
gem "mission_control-jobs", group: [:default, :wasm]
gem "solid_queue", group: [:default, :wasm]

# Assets
gem "importmap-rails", group: [:default, :wasm]
gem "propshaft", group: [:default, :wasm]
gem "tailwindcss-rails", "~> 2.6", group: [:default, :wasm]

# Hotwire
gem "stimulus-rails", group: [:default, :wasm]
gem "turbo-rails", group: [:default, :wasm]

# Authentication
gem "bcrypt", "~> 3.1.20", group: [:default, :wasm]

# Authorization
gem "action_policy", group: [:default, :wasm]

# Admin
gem "activestorage", group: [:default, :wasm]
gem "avo", ">= 3.2.1", group: [:default, :wasm]
gem "image_processing", group: [:default, :wasm]
gem "ransack", group: [:default, :wasm]

# Other
gem "bootsnap", require: false
gem "draper", group: [:default, :wasm]
gem "friendly_id", "~> 5.5.0", group: [:default, :wasm]
gem "inline_svg", group: [:default, :wasm]
gem "net-pop", github: "ruby/net-pop", group: [:default, :wasm]
gem "noticed", group: [:default, :wasm]
gem "puma", ">= 5.0"
gem "rqrcode", "~> 2.0", group: [:default, :wasm]
# gem "tzinfo-data", platforms: %i[windows jruby]
gem "validates_timeliness", "~> 7.0.0.beta1", group: [:default, :wasm]
gem "validate_url", group: [:default, :wasm]
# gem "web-push", group: [:default, :wasm]
gem "wasmify-rails", group: [:default, :wasm]

group :development, :test do
  gem "better_errors"
  gem "binding_of_caller"
  gem "brakeman"
  gem "bundle-audit"
  gem "database_consistency"
  gem "debug", platforms: %i[mri windows]
  gem "dotenv"
  gem "erb_lint", require: false
  gem "factory_bot_rails"
  gem "faker"
  gem "letter_opener", "~> 1.10"
  gem "pry-byebug"
  gem "rspec-rails"
  gem "rubocop-capybara", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false
  gem "rubycritic"
  gem "standard"
end

group :development do
  gem "annotate"
  gem "rack-mini-profiler"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "cuprite"
  gem "fuubar"
  gem "rails-controller-testing"
  gem "rspec-instafail", require: false
  gem "rspec-retry"
  gem "timecop"
end

group :staging, :production do
  gem "appsignal"
  gem "aws-sdk-s3", require: false
  gem "litestream", "~> 0.10.4"
  gem "lograge", group: [:default, :wasm]
  gem "mailpace-rails"
end

group :wasm do
  gem "tzinfo-data"
end
