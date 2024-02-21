# Deliver notifications to all users about the new story to all users who have enabled
# :notify_new_story in their preferences, except for the story creator (or story
# collaborators)

class NewStoryNotifier < Noticed::Event
  validates :record, presence: true

  deliver_by :email do |config|
    config.mailer = "NotificationMailer"
    config.method = :notify_new_story
    config.if = :email_notifications?
  end

  notification_methods do
    def message
      t(".message", title: record.title)
    end

    def url
      story_path(record)
    end
  end

  # @todo save to db if email_notification?

  # @todo make sure this checks for story collaborators as well when
  # collaboration feature is ready.
  # Note that we are not checking for recepient.preference.notify_new_story
  # here becasue this has already been filtered out in the deliver_later call
  def email_notifications?(notification)
    recipient = notification.recipient
    recipient.id != record.user.id
  end
end
