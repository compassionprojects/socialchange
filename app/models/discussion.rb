# Discussion model
#
class Discussion < ApplicationRecord
  include Discard::Model

  belongs_to :user
  belongs_to :story
  belongs_to :updater, class_name: "User"
  has_many :posts, dependent: :destroy
  has_noticed_notifications

  validates :title, :description, presence: true

  # @todo remove the unless filter
  # figure out why tests get stuck and thorw errors like these
  # https://github.com/compassionprojects/socialchange/actions/runs/7434566400/job/20228849583?pr=57
  # WARNING:  there is already a transaction in progress
  # ActiveRecord::StatementInvalid:
  #   PG::UnableToSend: insufficient data in "T" message
  #
  after_create_commit :notify, unless: -> { Rails.env.test? }

  # After a topic is discarded, discard it's posts
  #
  after_discard do
    posts.discard_all
  end

  after_undiscard do
    posts.undiscard_all
  end

  private

  def notify
    NewDiscussionNotification.with(discussion: self, story:).deliver_later([story.user])
  end
end
