require "rails_helper"

# we don't care that much about the user preference here
# becasuse that is taken care of in the Noticed notification class
# @todo improve these tests by testing for locales as well

describe NotificationMailer, type: :mailer do
  describe "#notify_new_story" do
    let(:user) { create(:user) }
    let(:story) { create(:story, title: "Test Story") }
    let(:mail) { described_class.with(recipient: user, story: story).notify_new_story }
    include_examples "a notification email", "A new NVC Social Change Story", "notify_new_story"
  end

  describe "#notify_new_discussion" do
    let(:user) { create(:user) }
    let(:story) { create(:story) }
    let(:discussion) { create(:discussion, title: "Test Discussion", story:) }
    let(:mail) { described_class.with(recipient: user, discussion: discussion, story: story).notify_new_discussion }
    include_examples "a notification email", "A new discussion", "notify_new_discussion"
  end

  describe "#notify_new_post" do
    let(:user) { create(:user) }
    let(:story) { create(:story) }
    let(:discussion) { create(:discussion, story:) }
    let(:post) { create(:post, discussion:) }
    let(:mail) { described_class.with(recipient: user, discussion: discussion, story: story, post: post).notify_new_post }
    include_examples "a notification email", "A new post", "notify_new_post"
  end
end
