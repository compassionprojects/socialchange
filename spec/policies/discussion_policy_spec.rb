require "rails_helper"

describe DiscussionPolicy do
  subject { described_class.new(user, discussion) }

  let(:user) { create(:user) }
  let(:story) { create(:story) }
  let(:discussion) { create(:discussion, story:) }

  context "any user wants to post to a discussion" do
    it { is_expected.to permit_actions(%i[new create]) }
  end

  context "when user is modifying someone else's discussion topic" do
    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_actions(%i[update edit destroy]) }
  end

  context "when user is modifying his own discussion topic" do
    let(:discussion) { create(:discussion, user:) }

    it { is_expected.to permit_actions(%i[update edit destroy show]) }
  end

  context "with discussions.update permission" do
    let(:user) { create(:user_with_permissions, permissions: ["discussions.update"]) }

    it { is_expected.to permit_actions(%i[update edit show]) }
    it { is_expected.to forbid_actions(%i[destroy]) }
  end

  context "with discussions.delete permission" do
    let(:user) { create(:user_with_permissions, permissions: ["discussions.delete"]) }

    it { is_expected.to permit_actions(%i[destroy show]) }
    it { is_expected.to forbid_actions(%i[update edit]) }
  end

  context "with discussions.manage permission" do
    let(:user) { create(:user_with_permissions, permissions: ["discussions.manage"]) }

    it { is_expected.to permit_actions(%i[destroy update edit show]) }
  end
end
