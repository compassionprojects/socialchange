module NotificationExtensions
  extend ActiveSupport::Concern

  included do
    def default_url_options
      Rails.application.routes.default_url_options
    end
  end
end
