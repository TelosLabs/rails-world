source "https://rubygems.org"

ruby "3.3.3"

gem "rails", "~> 8.0"

# Database
gem "activerecord-enhancedsqlite3-adapter", "~> 0.8.0"
gem "sqlite3", "~> 2.1"

# Jobs
gem "mission_control-jobs"
gem "solid_queue"

# Assets
gem "importmap-rails"
gem "propshaft"
gem "tailwindcss-rails", "~> 2.6"

# Hotwire
gem "stimulus-rails"
gem "turbo-rails"

# Deployment
gem "kamal", require: false

# Authentication
gem "bcrypt", "~> 3.1.20"

# Authorization
gem "action_policy"

# Admin
gem "activestorage"
gem "avo", ">= 3.17"
gem "image_processing"
gem "ransack"

# Security Updates
gem "net-imap", "~> 0.4.20"
gem "nokogiri", ">= 1.18.8"
gem "rack", ">= 3.1.14"
gem "rack-session", ">= 2.1.1"
gem "rails-html-sanitizer", ">= 1.6.1"
gem "rexml", ">= 3.3.9"

# Other
gem "bootsnap", require: false
gem "draper"
gem "friendly_id", "~> 5.5.0"
gem "inline_svg"
gem "net-pop", github: "ruby/net-pop"
gem "noticed"
gem "puma", ">= 5.0"
gem "rqrcode", "~> 2.0"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "validates_timeliness", "~> 8.0"
gem "validate_url"
gem "web-push"

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
  gem "lograge"
  gem "mailpace-rails"
end
