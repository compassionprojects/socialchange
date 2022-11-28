require "rails_helper"

describe UserPolicy do
  subject { described_class }
  let(:user1) { create(:user, email: "1@ex.com", password: "12345678", name: "test1") }
  let(:user2) { create(:user, email: "2@ex.com", password: "87654321", name: "test2") }
  let(:admin) { create(:user, email: "admin@ex.com", password: "admin123", name: "admin", role: :admin) }

  permissions :update? do
    it "denies access if user is updating another user" do
      expect(subject).not_to permit(user1, user2)
    end

    it "grants access if user is updating himself" do
      expect(subject).to permit(user1, user1)
    end

    it "grants access if admin is updating any other user" do
      expect(subject).to permit(admin, user1)
    end
  end
end
