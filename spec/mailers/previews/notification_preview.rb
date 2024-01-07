# Preview all emails at http://localhost:3000/rails/mailers/notification
class NotificationPreview < ActionMailer::Preview
  def notify_new_story
    NotificationMailer.with(recipient: User.first, story: Story.first).notify_new_story
  end

  def notify_new_discussion
    NotificationMailer.with(recipient: User.first, discussion: Discussion.first, story: Story.first).notify_new_discussion
  end

  def notify_new_post
    NotificationMailer.with(recipient: User.first, discussion: Discussion.first, story: Story.first, post: Post.first).notify_new_post
  end
end
