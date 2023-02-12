# DiscussionTopic policy
#
class DiscussionTopicPolicy < ApplicationPolicy
  # DiscussionTopic scope
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
    "discussion_topics"
  end

  def owns_resource?
    user.id == record.user.id
  end
end
