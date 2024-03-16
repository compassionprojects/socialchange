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

    # Active Record Encryption configuration
    config.active_record.encryption.primary_key = ENV["ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY"]
    config.active_record.encryption.deterministic_key = ENV["ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY"]
    config.active_record.encryption.key_derivation_salt = ENV["ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT"]

    # When true, queries referencing deterministically encrypted attributes
    # will be modified to include additional values if needed.
    # https://guides.rubyonrails.org/v7.0/active_record_encryption.html#config-active-record-encryption-extend-queries
    config.active_record.encryption.extend_queries = true

    # Support unencrypted data to ease migration
    # @todo - remove this once all data is encrypted and migrated
    config.active_record.encryption.support_unencrypted_data = true

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
