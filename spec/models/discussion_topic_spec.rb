require "rails_helper"

describe DiscussionTopic do
  describe "validations" do
    describe "title" do
      subject { build(:discussion_topic, title: "") }

      it { is_expected.to be_invalid }
    end

    describe "description" do
      subject { build(:discussion_topic, description: "") }

      it { is_expected.to be_invalid }
    end

    describe "story" do
      subject { build(:discussion_topic, story: nil) }

      it { is_expected.to be_invalid } # without a story
    end

    describe "user" do
      subject { build(:discussion_topic, user: nil) }

      it { is_expected.to be_invalid }
    end
  end
end
