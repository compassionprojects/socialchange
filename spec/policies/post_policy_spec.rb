require "rails_helper"

describe PostPolicy do
  subject { described_class.new(user, post) }

  let(:user) { create(:user) }
  let(:post) { create(:post) }

  context "any user wants to post to a discussion" do
    it { is_expected.to permit_actions(%i[new create]) }
  end

  context "when user is modifying someone else's discussion post" do
    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_actions(%i[update edit destroy]) }
  end

  context "when user is modifying his own discussion post" do
    let(:post) { create(:post, user:) }

    it { is_expected.to permit_actions(%i[update edit destroy show]) }
  end

  context "with posts.update permission" do
    let(:user) { create(:user_with_permissions, permissions: ["posts.update"]) }

    it { is_expected.to permit_actions(%i[update edit show]) }
    it { is_expected.to forbid_actions(%i[destroy]) }
  end

  context "with posts.delete permission" do
    let(:user) { create(:user_with_permissions, permissions: ["posts.delete"]) }

    it { is_expected.to permit_actions(%i[destroy show]) }
    it { is_expected.to forbid_actions(%i[update edit]) }
  end

  context "with posts.manage permission" do
    let(:user) { create(:user_with_permissions, permissions: ["posts.manage"]) }

    it { is_expected.to permit_actions(%i[destroy update edit show]) }
  end
end
