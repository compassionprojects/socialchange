# Permission model
#
class Permission < ApplicationRecord
  has_and_belongs_to_many :roles

  # @todo move this somewhere else!
  ACTIONS = %i[read list create update delete manage].freeze
  RESOURCES = %i[users roles permissions stories story_updates discussions posts].freeze
  AVAILABLE_PERMISSIONS = [] # rubocop:disable Style/MutableConstant
  RESOURCES.each do |resource|
    ACTIONS.each do |action|
      AVAILABLE_PERMISSIONS << "#{resource}.#{action}"
    end
  end

  validates :name, inclusion: {in: AVAILABLE_PERMISSIONS}, uniqueness: true
end
