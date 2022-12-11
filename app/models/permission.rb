# Permission model
#
class Permission < ApplicationRecord
  has_and_belongs_to_many :roles

  # @todo move this somewhere else!
  ACTIONS = %i[read list create update delete manage].freeze
  AVAILABLE_PERMISSIONS = [].freeze
  ApplicationRecord.descendants.collect(&:name).map(&:pluralize).each do |resource|
    ACTIONS.each do |action|
      AVAILABLE_PERMISSIONS << "#{resource.downcase}.#{action}"
    end
  end

  validates :name, inclusion: { in: AVAILABLE_PERMISSIONS }, uniqueness: true
end
