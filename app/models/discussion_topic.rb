# DiscussionTopic model
#
class DiscussionTopic < ApplicationRecord
  include Discard::Model

  belongs_to :user
  belongs_to :story
  belongs_to :updater, class_name: "User"
  has_many :discussion_posts

  validates :title, :description, presence: true

  # After a topic is discarded, discard it's posts
  #
  after_discard do
    discussion_posts.discard_all
  end

  after_undiscard do
    discussion_posts.undiscard_all
  end
end
