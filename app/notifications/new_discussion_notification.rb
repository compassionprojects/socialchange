# To deliver this notification:
#
# NewDiscussionNotification.with(post: @post).deliver_later(current_user)
# NewDiscussionNotification.with(post: @post).deliver(current_user)

class NewDiscussionNotification < Noticed::Base
  deliver_by :database, if: :email_notifications?
  deliver_by :email, mailer: "NotificationMailer", method: :notify_new_discussion, if: :email_notifications?

  # Add required params
  #
  param :discussion
  param :story

  # Define helper methods to make rendering easier.
  #
  def message
    t(".message", title: discussion.title, story_title: story.title)
  end

  def url
    story_discussion_path(story, discussion)
  end

  # Make sure recipient is not the discussion creator himself
  # Also check if recipient has a preference enabled to be notified
  def email_notifications?
    recipient.preference&.notify_new_discussion_on_story && recipient.id != discussion.user.id
  end

  def discussion
    params[:discussion]
  end

  def story
    params[:story]
  end
end
