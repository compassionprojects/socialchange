# Role policy
#
class RolePolicy < ApplicationPolicy
  def resource
    "roles"
  end

  def owns_resource?
    nil
  end
end
