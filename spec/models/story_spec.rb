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
end
