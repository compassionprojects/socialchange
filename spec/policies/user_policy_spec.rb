require "rails_helper"

describe UserPolicy do
  subject { described_class.new(user, record) }

  let(:user) { create(:user) }
  let(:record) { create(:user) }

  context "without any permissions" do
    let(:record) { create(:user) }

    it { is_expected.to forbid_actions(%i[update edit destroy show]) }
  end

  context "when user is modifying himself" do
    let(:record) { user }

    it { is_expected.to permit_actions(%i[update edit destroy show]) }
  end

  context "with users.update permission" do
    let(:user) { create(:user_with_permissions, permissions: ["users.update"]) }

    it { is_expected.to permit_actions(%i[update edit]) }
    it { is_expected.to forbid_actions(%i[destroy show]) }
  end

  context "with users.delete permission" do
    let(:user) { create(:user_with_permissions, permissions: ["users.delete"]) }

    it { is_expected.to permit_actions(%i[destroy]) }
    it { is_expected.to forbid_actions(%i[update edit show]) }
  end

  context "with users.manage permission" do
    let(:user) { create(:user_with_permissions, permissions: ["users.manage"]) }

    it { is_expected.to permit_actions(%i[destroy update edit show]) }
  end
end
