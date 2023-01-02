# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    can_manage_resource? || user.has_permission?(:list, resource)
  end

  def show?
    can_manage_resource? || user.has_permission?(:read, resource) || owns_resource?
  end

  def create?
    can_manage_resource? || user.has_permission?(:create, resource) || owns_resource?
  end

  def new?
    create?
  end

  def update?
    can_manage_resource? || user.has_permission?(:update, resource) || owns_resource?
  end

  def edit?
    update?
  end

  def destroy?
    can_manage_resource? || user.has_permission?(:delete, resource) || owns_resource?
  end

  protected

  def resource
    raise NotImplementedError
  end

  def owns_resource?
    raise NotImplementedError
  end

  private

  def can_manage_resource?
    user.has_permission?(:manage, resource)
  end
end
