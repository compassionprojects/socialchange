# User policy
#
class UserPolicy < ApplicationPolicy
  # User scope
  #
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.kept
    end

    private

    attr_reader :user, :scope
  end

  def resource
    "users"
  end

  def owns_resource?
    user.id == record.id
  end
end
