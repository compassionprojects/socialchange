source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Ruby version
ruby File.read(".ruby-version").strip

# Rails specific
gem "pg", "~> 1.5"                # Use postgresql as the database for Active Record
gem "puma", "~> 6.4"              # Use the Puma web server [https://github.com/puma/puma]
gem "rails", "~> 7.1.2"
gem "sprockets-rails"             # The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]

# Frontend asset bundling
gem "cssbundling-rails", "~> 1.1"
gem "importmap-rails"             # Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "jbuilder"                    # Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jsbundling-rails", "~> 1.2"
gem "stimulus-rails"              # Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "turbo-rails"                 # Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]

# Translatable content
gem "mobility", "~> 1.2"
gem "mobility-ransack", "~> 1.2.2"

# Soft deletions
gem "discard", "~> 1.2"

# Authentication
gem "devise", "~> 4.9"
gem "devise_invitable", "~> 2.0"
gem "responders", "~> 3.1.0"
gem "invisible_captcha", "~> 2.1"

# Authorisation
gem "pundit", "~> 2.2"

# Admin
gem "administrate", "~> 0.20.1"

# Locales
gem "rails-i18n", "~> 7.0"
gem "devise-i18n", "~> 1.12"

# Pagination
gem "kaminari", "~> 1.2"

# Notifications
gem "noticed", "~> 1.6"

# Error reporting
gem "bugsnag", "~> 6.26"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Misc gems required for the app
gem "country_select", "~> 8.0.3"
gem "trix-rails", require: "trix"

# Storing objects/images/documents
gem "aws-sdk-s3", require: false
gem "image_processing", ">= 1.2"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails", "~> 2.8"
end

group :development do
  gem "guard"
  gem "guard-rspec", require: false
  gem "web-console" # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "dockerfile-rails", ">= 1.5"

  # code quality and formatting
  gem "standard-rails", "~> 0.1.0"
  gem "standard", "~> 1.33.0"
end

group :test do
  gem "rspec-rails", "~> 6.0.0"
  gem "factory_bot_rails", "~> 6.2"
  gem "faker", "~> 3.2"
  gem "pundit-matchers", "~> 3.1"

  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  # @todo check if these are required and remove if not
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
