# Invite a story contributor
#
class InviteContributorNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "NotificationMailer", method: :invite_contributor # , if: :email_notifications?

  # Add required params
  #
  param :story

  # Define helper methods to make rendering easier.
  #
  def message
    t(".message", story_title: story.title)
  end

  def url
    story_path(story)
  end

  # def email_notifications?
  #   recipient.accepted_invitation?
  # end

  def story
    params[:story]
  end
end
