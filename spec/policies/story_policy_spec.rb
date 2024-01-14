require "rails_helper"

describe StoryPolicy do
  subject { described_class.new(user, story) }

  let(:user) { create(:user) }
  let(:story) { create(:story) }

  context "when user is modifying someone else's story" do
    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_actions(%i[update edit destroy]) }
  end

  context "when user is modifying his own story" do
    let(:story) { create(:story, user:) }

    it { is_expected.to permit_actions(%i[update edit destroy show]) }
  end

  context "when contributors are modifying a story" do
    let(:story) { create(:story, user:) }
    let(:contributor) { create(:user) }
    subject { described_class.new(contributor, story) }

    before do
      story.invite_contributors([contributor.email], user)
      story.reload
    end

    it { is_expected.to permit_actions(%i[update edit destroy show]) }
  end

  context "with stories.update permission" do
    let(:user) { create(:user_with_permissions, permissions: ["stories.update"]) }

    it { is_expected.to permit_actions(%i[update edit show]) }
    it { is_expected.to forbid_actions(%i[destroy]) }
  end

  context "with stories.delete permission" do
    let(:user) { create(:user_with_permissions, permissions: ["stories.delete"]) }

    it { is_expected.to permit_actions(%i[destroy show]) }
    it { is_expected.to forbid_actions(%i[update edit]) }
  end

  context "with stories.manage permission" do
    let(:user) { create(:user_with_permissions, permissions: ["stories.manage"]) }

    it { is_expected.to permit_actions(%i[destroy update edit show]) }
  end
end
