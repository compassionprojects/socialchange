require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Socialchange
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # https://guides.rubyonrails.org/configuring.html#configuring-i18n
    config.i18n.available_locales = %i[en nl]
    config.i18n.default_locale = :en
    config.i18n.fallbacks = true

    # set default email sender
    config.mailer_default_from = ENV["DOMAIN_EMAIL_ADDRESS"]

    # @todo - this should not be required and default_url_options should be
    # obeyed. It's a workaround for now.
    # include the default_url_options method in Notifiers
    config.to_prepare do
      Noticed::Notification.include NotificationExtensions
    end
  end
end
