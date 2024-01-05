class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.config.mailer_default_from
  layout "mailer"
end
