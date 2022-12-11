# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    can_manage_resource? || user.has_permission?(:list, resource)
  end

  def show?
    can_manage_resource? || user.has_permission?(:read, resource)
  end

  def create?
    can_manage_resource? || user.has_permission?(:create, resource)
  end

  def new?
    create?
  end

  def update?
    can_manage_resource? || user.has_permission?(:update, resource)
  end

  def edit?
    update?
  end

  def destroy?
    can_manage_resource? || user.has_permission?(:delete, resource)
  end

  protected

  def resource
    raise NotImplementedError
  end

  private

  def can_manage_resource?
    user.has_permission?(:manage, resource)
  end
end
