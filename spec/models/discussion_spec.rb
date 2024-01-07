require "rails_helper"

describe Discussion do
  describe "validations" do
    describe "title" do
      subject { build(:discussion, title: "") }

      it { is_expected.to be_invalid }
    end

    describe "description" do
      subject { build(:discussion, description: "") }

      it { is_expected.to be_invalid }
    end

    describe "story" do
      subject { build(:discussion, story: nil) }

      it { is_expected.to be_invalid } # without a story
    end

    describe "user" do
      subject { build(:discussion, user: nil) }

      it { is_expected.to be_invalid }
    end
  end

  describe "#discard" do
    let(:discussion) { create(:discussion) }

    it "discards all associated records" do
      create_list(:post, 3, discussion:)

      # Check if the records first exist
      expect(Post.kept.where(discussion:)).not_to be_empty

      discussion.discard

      # Check if the records are discarded after .discard
      expect(discussion.discarded_at).not_to be_nil
      expect(Post.kept).to be_empty
    end
  end

  describe "#participants" do
    let(:discussion) { create(:discussion) }

    it "lists all people who have participated on the discussion" do
      posts = create_list(:post, 3, discussion:)
      posts.first.discard # remove a post
      # since we removed one, that post participant should be excluded
      expect(discussion.participants.count).to eql(2)
    end
  end

  xdescribe "after_create_commit" do
    let(:discussion) { build(:discussion) }

    it "triggers the notify method from the hook" do
      allow(discussion).to receive(:notify).and_call_original
      discussion.save
      expect(discussion).to have_received(:notify)
    end
  end
end
