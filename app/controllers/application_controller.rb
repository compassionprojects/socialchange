class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include LocaleConcerns

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name language])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
    devise_parameter_sanitizer.permit(:invite, keys: [:name])
  end

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:alert] = I18n.t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_back(fallback_location: root_path)
  end
end
