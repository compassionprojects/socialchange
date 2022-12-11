# Permission policy
#
class PermissionPolicy < ApplicationPolicy
  # Permission scope
  #
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end

  def resource
    "permissions"
  end

  def owns_resource?
    nil
  end
end
