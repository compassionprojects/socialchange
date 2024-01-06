# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview
  def notify_new_story
    UserMailer.with(recipient: User.first, story: Story.first).notify_new_story
  end
end
