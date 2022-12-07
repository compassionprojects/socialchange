class Story < ApplicationRecord
  extend Mobility

  belongs_to :user
  belongs_to :updater, class_name: "User"

  enum :status, %i[draft published]

  translates :title, :description, :outcomes, :source
end
