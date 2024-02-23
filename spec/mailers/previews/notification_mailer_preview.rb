# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def notify_new_story
    NotificationMailer.with(recipient: User.first, record: Story.first).notify_new_story
  end

  def notify_new_discussion
    NotificationMailer.with(recipient: User.first, record: Discussion.first, story: Story.first).notify_new_discussion
  end

  def notify_new_post
    NotificationMailer.with(recipient: User.first, discussion: Discussion.first, story: Story.first, record: Post.first).notify_new_post
  end

  def invite_contributor
    NotificationMailer.with(record: User.first, story: Story.first).invite_contributor
  end
end
