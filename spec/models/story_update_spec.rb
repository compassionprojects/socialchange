require "rails_helper"

describe StoryUpdate do
  describe "validations" do
    describe "title" do
      subject { build(:story_update, title: "") }

      it { is_expected.to be_invalid }
    end

    describe "description" do
      subject { build(:story_update, description: "") }

      it { is_expected.to be_invalid }
    end

    describe "story" do
      subject { build(:story_update, story: nil) }

      it { is_expected.to be_invalid }
    end

    describe "user" do
      subject { build(:story_update, user: nil) }

      it { is_expected.to be_invalid }
    end

    describe "updater" do
      subject { build(:story_update, updater: nil) }

      it { is_expected.to be_invalid }
    end

    context "when valid" do
      subject { build(:story_update) }

      it { is_expected.to be_valid }
    end
  end
end
