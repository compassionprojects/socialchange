# Category policy
#
class CategoryPolicy < ApplicationPolicy
  # Category scope
  #
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.order(created_at: :desc)
    end

    private

    attr_reader :user, :scope
  end

  def new?
    create?
  end

  def create?
    signed_in?
  end

  # Allowed attributes to be updated
  # can also use `permitted_attributes_for_create`, `permitted_attributes_for_update`
  def permitted_attributes
    %i[name]
  end

  def resource
    "categories"
  end

  def owns_resource?
    true
  end
end
