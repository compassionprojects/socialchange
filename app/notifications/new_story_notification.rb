# Deliver notifications to all users about the new story to all users who have enabled
# :notify_new_story in their preferences, except for the story creator (or story
# collaborators)

class NewStoryNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "NotificationMailer", method: :notify_new_story, if: :email_notifications?

  # Add required params
  #
  param :story

  # Define helper methods to make rendering easier.
  #
  def message
    t(".message", title: story.title)
  end

  def url
    story_path(story)
  end

  # @todo make sure this checks for story collaborators as well when
  # collaboration feature is ready.
  # Note that we are not checking for recepient.preference.notify_new_story
  # here becasue this has already been filtered out in the deliver_later call
  def email_notifications?
    recipient.id != story.user.id
  end

  def story
    params[:story]
  end
end
