require "rails_helper"

describe UserMailer, type: :mailer do
  describe "#notify_new_story" do
    # we don't care that much about the user preference here
    # becasuse that is taken care of in the Noticed notification class
    let(:user) { create(:user) }
    let(:story) { create(:story, title: "Test Story") }
    let(:mail) { described_class.with(recipient: user, story:).notify_new_story }

    it "sends an email to the user with the correct subject" do
      expect(mail.subject).to eq("A new NVC Social Change Story 'Test Story' was published")
    end

    it "sends the email to the correct recipient" do
      expect(mail.to).to eq([user.email])
    end

    it "renders the body with the user and story information" do
      expect(mail.body.encoded).to include(user.name.split(" ").first)
      expect(mail.body.encoded).to include("Test Story")
    end

    it "uses the user's preferred language for the email content" do
      # Assuming there are translations
      I18n.with_locale(user.language) do
        expect(mail.subject).to eq(I18n.t("user_mailer.notify_new_story.subject", title: story.title))
      end
    end
  end
end
