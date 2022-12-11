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
      scope.kept
    end

    private

    attr_reader :user, :scope
  end

  def resource
    "stories"
  end

  def owns_resource?
    user.id == record.user.id
  end
end
