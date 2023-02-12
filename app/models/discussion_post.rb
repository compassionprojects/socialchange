# DiscussionPost model
#
class DiscussionPost < ApplicationRecord
  include Discard::Model

  belongs_to :discussion_topic
  belongs_to :user
  belongs_to :updater, class_name: "User"

  validates :body, presence: true
end
