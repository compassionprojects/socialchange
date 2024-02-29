# Discussion model
#
class Discussion < ApplicationRecord
  include Discard::Model

  belongs_to :user
  belongs_to :story
  belongs_to :updater, class_name: "User"
  has_many :posts, dependent: :destroy
  has_many :noticed_events, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  has_many :notifications, through: :noticed_events, class_name: "Noticed::Notification"

  validates :title, :description, presence: true

  after_create_commit :notify

  # After a topic is discarded, discard it's posts
  #
  after_discard do
    posts.discard_all
  end

  after_undiscard do
    posts.undiscard_all
  end

  def participants
    User.joins(:posts).merge(Post.kept.where(discussion_id: id)).distinct
  end

  private

  # Make sure recipient is not the discussion creator himself
  # Also check if recipient has a preference enabled to be notified
  def can_notify?(recipient)
    recipient.preference&.notify_new_discussion_on_story && recipient.id != user.id
  end

  def notify
    NewDiscussionNotifier.with(record: self, story:).deliver_later([story.user]) if can_notify?(story.user)
  end
end
