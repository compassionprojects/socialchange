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

  def notify
    # notify discussion creator and anyone else participating in the discussion
    participants = (discussion.participants + [discussion.user]).uniq
    NewPostNotifier.with(record: self, discussion:, story: discussion.story).deliver_later(participants)
  end
end
