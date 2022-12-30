# Story policy
#
class StoryPolicy < ApplicationPolicy
  # Story scope
  #
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      # get only undiscarded stories
      scope.kept.published
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
    %i[title description country outcomes source]
  end

  def resource
    "stories"
  end

  def owns_resource?
    user.id == record.user.id
  end
end
