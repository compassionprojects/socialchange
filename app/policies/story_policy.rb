class StoryPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end

  def show?
    true
  end

  # Allow only creators and site admins to update stories
  # @todo allow contrinutors to update as well later
  #
  def update?
    user.admin? || user.id == record.user.id
  end

  def index?
    true
  end

  def destroy?
    user.admin? || user.id == record.user.id
  end
end
