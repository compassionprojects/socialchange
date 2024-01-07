# To deliver this notification:
#
# NewPostNotification.with(post: @post).deliver_later(current_user)
# NewPostNotification.with(post: @post).deliver(current_user)

class NewPostNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: "NotificationMailer", method: :notify_new_post, if: :email_notifications?

  # Add required params
  #
  param :post
  param :discussion
  param :story

  # Define helper methods to make rendering easier.
  #
  def message
    t(".message", title: post.body)
  end

  def url
    story_discussion_path(story, discussion)
  end

  # we send notifications to all participants who have set their preference
  # and also to the discussion creator if preference is set
  def email_notifications?
    # skip when recipient is the post creator
    return false if recipient.id == post.user.id
    if recipient.id == discussion.user.id # discussion owner
      recipient.preference.notify_new_post_on_discussion
    else # any participants in post
      recipient.preference.notify_any_post_in_discussion
    end
  end

  def post
    params[:post]
  end

  def discussion
    params[:discussion]
  end

  def story
    params[:story]
  end
end
