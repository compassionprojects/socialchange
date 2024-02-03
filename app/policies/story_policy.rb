# Story policy
#
class StoryPolicy < ApplicationPolicy
  # Story scope
  #
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      # get only undiscarded stories
      scope.kept.order(created_at: :desc)
    end

    private

    attr_reader :user, :scope
  end

  def show?
    !record.discarded?
  end

  # Allowed attributes to be updated
  # can also use `permitted_attributes_for_create`, `permitted_attributes_for_update`
  def permitted_attributes
    %i[title description country outcomes source category_id] + [documents: []]
  end

  def resource
    "stories"
  end

  # for now assume all contributors have the same permissions as the owner
  def owns_resource?
    user.id == record.user.id
  end

  def update?
    can_manage_resource? || user.has_permission?(:update, resource) || owns_resource? || record.contributed?(user)
  end
end
