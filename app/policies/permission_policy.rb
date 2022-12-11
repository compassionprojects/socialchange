# Permission policy
#
class PermissionPolicy < ApplicationPolicy
  def resource
    "permissions"
  end

  def owns_resource?
    nil
  end
end
