# Invite a story contributor
#
class InviteContributorNotifier < Noticed::Event
  validates :record, presence: true

  deliver_by :email do |config|
    config.mailer = "NotificationMailer"
    config.method = :invite_contributor
  end

  required_param :story

  notification_methods do
    def message
      t(".message", story_title: story.title)
    end

    def url
      story_path(story)
    end
  end

  def story
    params[:story]
  end
end
