source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Ruby version
ruby File.read(".ruby-version").strip

# Rails specific
gem "pg", "~> 1.1"                # Use postgresql as the database for Active Record
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

# Authentication and authorisation
gem "devise", "~> 4.8"
gem "devise_invitable", "~> 2.0"

# Locales
gem "rails-i18n", "~> 7.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Authorisation
gem "pundit", "~> 2.2"

# Admin
gem "administrate", "~> 0.19.0"

# Translatable content
gem "mobility", "~> 1.2"
gem "mobility-ransack", "~> 1.2.2"

# Soft deletions
gem "discard", "~> 1.2"

# Pagination
gem "kaminari", "~> 1.2"

gem "country_select", "~> 8.0.3"
gem "trix-rails", require: "trix"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails", "~> 2.8"
  gem "factory_bot_rails", "~> 6.2"
  gem "rspec-rails", "~> 6.0.0"

  gem "faker", "~> 3.0"

  gem "standard-rails", "~> 0.1.0"
  gem "standard", "~> 1.29.0"
end

group :development do
  gem "guard"
  gem "guard-rspec", require: false
  gem "web-console" # Use console on exceptions pages [https://github.com/rails/web-console]

  # @todo review the below commented out gems

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  # @todo check if these are required and remove if not
  gem "capybara"
  gem "pundit-matchers", "~> 3.1"
  gem "selenium-webdriver"
  gem "webdrivers"
end

# @todo review the below gems that are added but commented out during rails init

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "aws-sdk-s3", require: false
gem "image_processing", ">= 1.2"

gem "devise-i18n", "~> 1.10"

gem "dockerfile-rails", ">= 1.5", group: :development

gem "bugsnag", "~> 6.26"
gem "noticed", "~> 1.6"
