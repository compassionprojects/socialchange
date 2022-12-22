require "rails_helper"

describe StoryPolicy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:moderator) do
    create(:user, roles: [
      create(:role, name: "moderator", permissions: [create(:permission, name: "stories.update")])
    ])
  end
  let(:admin) do
    create(:user, roles: [
      create(:role, name: "admin", permissions: [
        create(:permission, name: "stories.manage")
      ])
    ])
  end
  let(:story) do
    create(:story, updater: user, user:)
  end

  permissions :update?, :edit? do
    it "denies access if user does not have permission to update the story" do
      expect(subject).not_to permit(another_user, story)
    end

    it "grants access if user is the creator" do
      expect(subject).to permit(user, story)
    end

    it "grants access if user with permission is updating the story" do
      expect(subject).to permit(moderator, story)
    end

    it "grants access if user with .manage permissions is updating the story" do
      expect(subject).to permit(admin, story)
    end
  end

  permissions :destroy? do
    let(:moderator) do
      create(:user, roles: [
        create(:role, name: "moderator", permissions: [create(:permission, name: "stories.delete")])
      ])
    end

    it "denies access if user does not have permission to destroy the story" do
      expect(subject).not_to permit(another_user, story)
    end

    it "grants access if user is destroying his own story" do
      expect(subject).to permit(user, story)
    end

    it "grants access if user with permission is destroying a story" do
      expect(subject).to permit(moderator, story)
    end

    it "grants access if user with .manage permissions is destroying a story" do
      expect(subject).to permit(admin, story)
    end
  end
end
