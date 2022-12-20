# Locale concerns
#
module LocaleConcerns
  extend ActiveSupport::Concern

  included do
    before_action :set_locale
  end

  # Set user locale based on 1) query param 2) profile preference 3) http header
  # in that order
  # @todo use cookie to store the preference and read from it
  #
  def set_locale
    preferred_locale = current_user.language if user_signed_in?

    locale = params[:lang].presence || preferred_locale.presence || locale_from_header
    I18n.locale = valid_locales.include?(locale) ? locale : I18n.default_locale
  end

  def locale_from_header
    request.env.fetch("HTTP_ACCEPT_LANGUAGE", "").scan(/[a-z]{2}/).first
  end

  private

  def valid_locales
    I18n.available_locales.map(&:to_s)
  end
end
