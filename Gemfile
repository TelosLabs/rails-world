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

# Hotwire
gem "turbo-rails"
gem "stimulus-rails"

# Other
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false

group :development, :test do
  gem "dotenv"
  gem "pry-byebug"
  gem "debug", platforms: %i[mri windows]
end

group :development do
  gem "web-console"
  gem "rack-mini-profiler"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
