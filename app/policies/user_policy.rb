class UserPolicy < ApplicationPolicy
  def resource
    "users"
  end

  def owns_resource?
    user.id == record.id
  end
end
