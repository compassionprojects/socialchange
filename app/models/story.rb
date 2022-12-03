class Story < ApplicationRecord
  extend Mobility

  belongs_to :user
  belongs_to :updater, class_name: "User"

  enum :status, %i[draft published archived]

  translates :title, :description, :outcomes, :source
end
