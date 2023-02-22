# Post policy
#
class PostPolicy < ApplicationPolicy
  # Post scope
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

  def new?
    create?
  end

  def create?
    is_signed_in?
  end

  # Allowed attributes to be updated
  # can also use `permitted_attributes_for_create`, `permitted_attributes_for_update`
  def permitted_attributes
    %i[body]
  end

  def show?
    !record.discarded?
  end

  def resource
    "posts"
  end

  def owns_resource?
    user.id == record.user.id
  end
end
