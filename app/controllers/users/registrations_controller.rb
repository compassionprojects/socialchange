class Users::RegistrationsController < Devise::RegistrationsController
  def update
    authorize resource
    super
  end
end
