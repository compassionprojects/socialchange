class UserPolicy < ApplicationPolicy

  # Allow only current users and site admins to update users profile
  # Devise too, manages this and only allows updating of current_user profile
  # But we have added this as a failsafe
  #
  def update?
    user.admin? || user.id == record.id
  end
end
