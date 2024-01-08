require "rails_helper"

describe Story do
  describe "validations" do
    describe "title" do
      subject { build(:story, title: "") }

      it { is_expected.to be_invalid }
    end

    describe "description" do
      subject { build(:story, description: "") }

      it { is_expected.to be_invalid }
    end

    describe "user" do
      subject { build(:story, user: nil) }

      it { is_expected.to be_invalid }
    end

    describe "updater" do
      subject { build(:story, updater: nil) }

      it { is_expected.to be_invalid }
    end

    context "when valid" do
      subject { build(:story) }

      it { is_expected.to be_valid }
    end
  end

  describe "#translation?" do
    subject do
      Mobility.locale = :en
      build(:story)
    end

    it { is_expected.to have_translation(:en) }
    it { is_expected.not_to have_translation(:nl) }
  end

  describe "#missing_translations" do
    subject(:story) do
      Mobility.locale = :en
      build(:story)
    end

    it { is_expected.to respond_to(:missing_translations) }

    it "returns locales for which translations are missing" do
      expect(story.missing_translations).to eql [:nl]
    end
  end

  describe "#translated_in" do
    subject(:story) do
      Mobility.locale = :en
      build(:story)
    end

    it { is_expected.to respond_to(:translated_in) }

    it "returns locales in which translations exist" do
      expect(story.translated_in).to eql [:en]
    end
  end

  describe "discard" do
    let(:story) { create(:story) }

    # rubocop:disable RSpec/ExampleLength
    # rubocop:disable RSpec/MultipleExpectations
    it "discards all associated records" do
      create_list(:discussion, 3, story:, posts: create_list(:post, 3))
      create_list(:story_update, 3, story:)

      # Check if the records first exist
      expect(Discussion.kept.where(story:)).not_to be_empty
      expect(StoryUpdate.kept.where(story:)).not_to be_empty
      expect(Post.kept).not_to be_empty

      story.discard

      # Here posts should also be discarded as this callback is run
      # after a discussion is discarded

      # Check if the records are discarded after .discard
      expect(story.discarded_at).not_to be_nil
      expect(Discussion.kept.where(story:)).to be_empty
      expect(StoryUpdate.kept.where(story:)).to be_empty
      expect(Post.kept).to be_empty
    end
    # rubocop:enable RSpec/ExampleLength
    # rubocop:enable RSpec/MultipleExpectations
  end

  describe "after_create_commit" do
    let(:story) { build(:story) }

    it "triggers the notify method from the hook" do
      allow(story).to receive(:notify).and_call_original
      story.save
      expect(story).to have_received(:notify)
    end
  end

  describe "#invite_contributors" do
    let!(:user) { create(:user) }
    let!(:story) { create(:story) }
    let!(:contributor) { create(:contribution, story:).user }
    let(:emails) { ["one@ex.com", "two@ex.com"] }
    let!(:inviter) { create(:user) }

    it "calls the instance method" do
      allow(story).to receive(:invite_contributors).with(emails)
      story.invite_contributors(emails)
      expect(story).to have_received(:invite_contributors).with(emails)
    end

    it "allows only the story owner or a contributor to invite" do
      expect do
        story.invite_contributors(emails, inviter)
      end.to raise_error(StandardError)
    end

    context "when user does not exist" do
      it "adds contributors as users" do
        expect do
          story.invite_contributors(emails, story.user)
        end.to change { User.count }.by(2)
      end

      xit "invites user only once even if invited multiple times" do
        ActiveJob::Base.queue_adapter = :test
        expect do
          story.invite_contributors(emails + emails, story.user)
        end.to have_enqueued_job.twice
      end

      it "adds contributions" do
        expect do
          story.invite_contributors(emails, story.user)
        end.to change { Contribution.count }.by(2)
      end
    end

    context "when user exists" do
      context "when user is not a contributor" do
        it "does not create a new user" do
          expect do
            story.invite_contributors([user.email], story.user)
          end.not_to change { User.count }
        end

        it "adds a contribution" do
          expect do
            story.invite_contributors([user.email], story.user)
          end.to change { Contribution.count }.by(1)
          story.reload
          expect(story.contributors).to include(user)
        end
      end

      context "when user is a contributor" do
        it "does not create a new user" do
          expect do
            story.invite_contributors([contributor.email], story.user)
          end.not_to change { User.count }
        end

        it "does not add him again" do
          expect do
            story.invite_contributors([contributor.email], story.user)
          end.not_to change { Contribution.count }
        end
      end
    end
  end
end
