# Post model
#
class Post < ApplicationRecord
  include Discard::Model

  belongs_to :discussion
  belongs_to :user
  belongs_to :updater, class_name: "User"
  has_many :noticed_events, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  has_many :notifications, through: :noticed_events, class_name: "Noticed::Notification"

  validates :body, presence: true

  # @todo remove the unless filter after fixing the tests
  # same issue as discussion model
  after_create_commit :notify, unless: -> { Rails.env.test? }

  private

  # we send notifications to all participants who have set their preference
  # and also to the discussion creator if preference is set
  def can_notify?(recipient)
    # skip when recipient is the post creator
    return false if recipient.id == user.id
    if recipient.id == discussion.user.id # discussion owner
      recipient.preference&.notify_new_post_on_discussion
    else # any participants in post
      recipient.preference&.notify_any_post_in_discussion
    end
  end

  def notify
    # notify discussion creator and anyone else participating in the discussion
    participants = (discussion.participants + [discussion.user]).uniq.select { |recipient| can_notify?(recipient) }
    NewPostNotifier.with(record: self, discussion:, story: discussion.story).deliver_later(participants) unless participants.empty?
  end
end
