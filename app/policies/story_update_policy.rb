# StoryUpdate policy
#
class StoryUpdatePolicy < ApplicationPolicy
  # StoryUpdate scope
  #
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      # get only undiscarded story updates
      scope.kept
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
    %i[title description]
  end

  def resource
    "story_updates"
  end

  def owns_resource?
    user.id == record.user.id
  end
end
