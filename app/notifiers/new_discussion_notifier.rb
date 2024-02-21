# NewDiscussionNotifier
#
class NewDiscussionNotifier < Noticed::Event
  validates :record, presence: true

  deliver_by :email do |config|
    config.mailer = "NotificationMailer"
    config.method = :notify_new_discussion
    config.if = :email_notifications?
  end

  required_params :story

  notification_methods do
    def message
      t(".message", title: record.title, story_title: story.title)
    end

    def url
      story_discussion_path(story, record)
    end
  end

  # @todo save to db if email_notification?

  # Make sure recipient is not the discussion creator himself
  # Also check if recipient has a preference enabled to be notified
  def email_notifications?(notification)
    recipient = notification.recipient
    recipient.preference&.notify_new_discussion_on_story && recipient.id != record.user.id
  end

  def story
    params[:story]
  end
end
