# Deliver notifications to all users about the new story to all users who have enabled
# :notify_new_story in their preferences, except for the story creator (or story
# collaborators)

class NewStoryNotifier < ApplicationNotifier
  validates :record, presence: true

  deliver_by :email do |config|
    config.mailer = "NotificationMailer"
    config.method = :notify_new_story
  end

  notification_methods do
    def message
      t(".message", title: record.title)
    end

    def url
      story_path(record)
    end
  end
end
