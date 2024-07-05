source "https://rubygems.org"

ruby "3.3.3"

gem "rails", "~> 7.1.3", ">= 7.1.3.4"

# Database
gem "activerecord-enhancedsqlite3-adapter", "~> 0.8.0"
gem "sqlite3", "~> 1.4"

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

# Authorization
gem "action_policy", "~> 0.7.0"

# Other
gem "bootsnap", require: false
gem "puma", ">= 5.0"
gem "rack-attack", "~> 6.7"
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "brakeman"
  gem "bundle-audit"
  gem "database_consistency"
  gem "debug", platforms: %i[mri windows]
  gem "dotenv"
  gem "erb_lint", require: false
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
  gem "rack-mini-profiler"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "cuprite"
  gem "fuubar"
  gem "rspec-instafail", require: false
  gem "rspec-retry"
end
