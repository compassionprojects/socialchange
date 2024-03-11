source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Ruby version
ruby File.read(".ruby-version").strip

# Rails specific
gem "pg", "~> 1.5"                # Use postgresql as the database for Active Record
gem "puma", "~> 6.4"              # Use the Puma web server [https://github.com/puma/puma]
gem "rails", "~> 7.1.3"

# Frontend asset bundling
gem "cssbundling-rails", "~> 1.4"
gem "jbuilder"                    # Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jsbundling-rails", "~> 1.3"
gem "stimulus-rails"              # Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "turbo-rails"                 # Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]

# Translatable content
gem "mobility", "~> 1.2"
gem "mobility-ransack", "~> 1.2.2"

# Soft deletions
gem "discard", "~> 1.2"

# Hierarchical data
gem "ancestry", "~> 4.3"

# Authentication
gem "devise", "~> 4.9"
gem "devise_invitable", "~> 2.0"
gem "responders", "~> 3.1.0"
gem "invisible_captcha", "~> 2.2"

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
gem "noticed", "~> 2.1"

# Error reporting
gem "bugsnag", "~> 6.26"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Misc gems required for the app
gem "country_select", "~> 8.0.3"
gem "trix-rails", require: "trix"
gem "react-rails", "~> 3.2"

# Storing objects/images/documents
gem "aws-sdk-s3", require: false
gem "image_processing", ">= 1.2"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails", "~> 3.1"
end

group :development do
  gem "guard"
  gem "guard-rspec", require: false
  gem "web-console" # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "dockerfile-rails", ">= 1.5"

  # code quality and formatting
  gem "standard-rails", "~> 1.0.2"
  gem "standard", "~> 1.34.0"
end

group :test do
  gem "rspec-rails", "~> 6.0.0"
  gem "factory_bot_rails", "~> 6.2"
  gem "faker", "~> 3.2"
  gem "pundit-matchers", "~> 3.1"
  gem "capybara"

  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  # @todo check if these are required and remove if not
  gem "selenium-webdriver"
  gem "webdrivers"
end
