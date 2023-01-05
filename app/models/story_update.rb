class StoryUpdate < ApplicationRecord
  extend Mobility
  include Discard::Model
  include Translatable

  belongs_to :story
  belongs_to :user
  belongs_to :updater, class_name: "User"

  validates :title, :description, presence: true
  translates :title, :description
end
