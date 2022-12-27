require "rails_helper"

describe StoryUpdatePolicy do
  subject { described_class.new(user, story_update) }

  let(:user) { create(:user) }
  let(:story_update) { create(:story_update) }

  context "when user is modifying someone else's story_update" do
    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_actions(%i[update edit destroy]) }
  end

  context "when user is modifying his own story_update" do
    let(:story_update) { create(:story_update, user:) }

    it { is_expected.to permit_actions(%i[update edit destroy show]) }
  end

  context "with story_updates.update permission" do
    let(:user) { create(:user_with_permissions, permissions: ["story_updates.update"]) }

    it { is_expected.to permit_actions(%i[update edit show]) }
    it { is_expected.to forbid_actions(%i[destroy]) }
  end

  context "with story_updates.delete permission" do
    let(:user) { create(:user_with_permissions, permissions: ["story_updates.delete"]) }

    it { is_expected.to permit_actions(%i[destroy show]) }
    it { is_expected.to forbid_actions(%i[update edit]) }
  end

  context "with story_updates.manage permission" do
    let(:user) { create(:user_with_permissions, permissions: ["story_updates.manage"]) }

    it { is_expected.to permit_actions(%i[destroy update edit show]) }
  end
end
