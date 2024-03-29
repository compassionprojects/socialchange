class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include LocaleConcerns

  # @todo remove these after most features have been developed
  # after_action :verify_authorized, except: %i[index show] # only for development
  # after_action :verify_policy_scoped, only: :index # only for development

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name dummie_hpot_field]) # :dummie_hpot_field is for invisible_captcha
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name language])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[name])
    devise_parameter_sanitizer.permit(:invite, keys: %i[name])
  end

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:alert] = I18n.t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_back(fallback_location: root_path)
  end

  def creator
    {user: current_user, updater: current_user}
  end
end
