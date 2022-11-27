class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def set_locale
    if user_signed_in?
      preferred_locale = current_user.language
    end

    locale = params[:lang].presence || preferred_locale.presence || locale_from_header
    I18n.locale = valid_locales.include?(locale) ? locale : I18n.default_locale
  end

  def locale_from_header
    request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :language])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
    devise_parameter_sanitizer.permit(:invite, keys: [:name])
  end

  private

  def valid_locales
    I18n.available_locales.map(&:to_s)
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:alert] = I18n.t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_back(fallback_location: root_path)
  end
end
