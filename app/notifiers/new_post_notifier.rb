# NewPostNotifier
#
class NewPostNotifier < ApplicationNotifier
  validates :record, presence: true

  deliver_by :email do |config|
    config.mailer = "NotificationMailer"
    config.method = :notify_new_post
    config.if = :email_notifications?
  end

  required_params :discussion, :story

  notification_methods do
    def message
      t(".message", discussion_title: event.discussion.title)
    end

    def url
      story_discussion_path(event.story, event.discussion)
    end
  end

  # @todo save to db if email_notification?

  # we send notifications to all participants who have set their preference
  # and also to the discussion creator if preference is set
  def email_notifications?(notification)
    recipient = notification.recipient
    # skip when recipient is the post creator
    return false if recipient.id == record.user.id
    if recipient.id == discussion.user.id # discussion owner
      recipient.preference&.notify_new_post_on_discussion
    else # any participants in post
      recipient.preference&.notify_any_post_in_discussion
    end
  end

  def discussion
    params[:discussion]
  end

  def story
    params[:story]
  end
end
