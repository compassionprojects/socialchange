# Discussion policy
#
class DiscussionPolicy < ApplicationPolicy
  # Discussion scope
  #
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.kept.includes(:user).order(created_at: :desc)
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
    %i[title description]
  end

  def index?
    !!user
  end

  def show?
    !record.discarded?
  end

  def resource
    "discussions"
  end

  def owns_resource?
    user.id == record.user.id
  end
end
