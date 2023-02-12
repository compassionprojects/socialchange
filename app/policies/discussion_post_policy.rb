# DiscussionPost policy
#
class DiscussionPostPolicy < ApplicationPolicy
  # DiscussionPost scope
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
    "discussion_posts"
  end

  def owns_resource?
    user.id == record.user.id
  end
end
