class Story < ApplicationRecord
  extend Mobility
  include Discard::Model

  belongs_to :user
  belongs_to :updater, class_name: "User"

  enum :status, %i[draft published]

  translates :title, :description, :outcomes, :source

  validates :title, :description, presence: true

  scope :published, -> { where("title ? '#{I18n.locale}'").and(where("description ? '#{I18n.locale}'")) }
end
