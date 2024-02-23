# NewPostNotifier
#
class NewPostNotifier < ApplicationNotifier
  validates :record, presence: true

  deliver_by :email do |config|
    config.mailer = "NotificationMailer"
    config.method = :notify_new_post
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

  def discussion
    params[:discussion]
  end

  def story
    params[:story]
  end
end
