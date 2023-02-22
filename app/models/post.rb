# Post model
#
class Post < ApplicationRecord
  include Discard::Model

  belongs_to :discussion
  belongs_to :user
  belongs_to :updater, class_name: "User"

  validates :body, presence: true
end
