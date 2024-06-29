source "https://rubygems.org"

ruby "3.3.3"

gem "rails", "~> 7.1.3", ">= 7.1.3.4"

# Database
gem "sqlite3", "~> 1.4"
gem "activerecord-enhancedsqlite3-adapter", "~> 0.8.0"

# Jobs
gem "solid_queue"
gem "mission_control-jobs"

# Assets
gem "propshaft"
gem "importmap-rails"
gem "tailwindcss-rails", "~> 2.6"

# Hotwire
gem "turbo-rails"
gem "stimulus-rails"

# Authorization
gem "action_policy", "~> 0.7.0"

# Other
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false

group :development, :test do
  gem "dotenv"
  gem "pry-byebug"
  gem "rspec-rails"
end

group :development do
  gem "web-console"
  gem "rack-mini-profiler"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
