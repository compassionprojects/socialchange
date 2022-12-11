require "rails_helper"

describe UserPolicy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:moderator) do
    create(:user, roles: [
      create(:role, name: "moderator", permissions: [create(:permission, name: "users.update")])
    ])
  end
  let(:admin) do
    create(:user, roles: [
      create(:role, name: "admin", permissions: [
        create(:permission, name: "users.manage")
      ])
    ])
  end

  permissions :update? do
    it "denies access if user does not have permission to update another user" do
      expect(subject).not_to permit(user, moderator)
    end

    it "grants access if user is updating himself" do
      expect(subject).to permit(user, user)
    end

    it "grants access if user with permission is updating another user" do
      expect(subject).to permit(moderator, user)
    end

    it "grants access if user with .manage permissions is updating another user" do
      expect(subject).to permit(admin, user)
    end
  end
end
