class UserPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      return unless user.admin?

      scope.all
    end

    private

    attr_reader :user, :scope
  end

  def show?
    user.admin? || user.id == record.id
  end

  # Allow only current users and site admins to update users profile
  #
  def update?
    user.admin? || user.id == record.id
  end

  def index?
    user.admin?
  end

  def destroy?
    user.admin? || user.id == record.id
  end
end
