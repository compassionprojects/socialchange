# NewDiscussionNotifier
#
class NewDiscussionNotifier < ApplicationNotifier
  validates :record, presence: true

  deliver_by :email do |config|
    config.mailer = "NotificationMailer"
    config.method = :notify_new_discussion
  end

  required_params :story

  notification_methods do
    def message
      t(".message", title: record.title, story_title: event.story.title)
    end

    def url
      story_discussion_path(event.story, record)
    end
  end

  def story
    params[:story]
  end
end
