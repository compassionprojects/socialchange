class Permission < ApplicationRecord
  has_and_belongs_to_many :roles

  AVAILABLE_PERMISSIONS = ["resources.manage"]
  ApplicationRecord.descendants.collect(&:name).map(&:pluralize).each do |resource|
    [:read, :list, :create, :update, :delete, :manage].each do |action|
      AVAILABLE_PERMISSIONS << "#{resource.downcase}.#{action}"
    end
  end

  validates :name, inclusion: { in: AVAILABLE_PERMISSIONS }, uniqueness: true
end
