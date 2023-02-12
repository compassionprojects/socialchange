require "rails_helper"

describe DiscussionPost do
  describe "validations" do
    describe "body" do
      subject { build(:discussion_post, body: nil) }

      it { is_expected.to be_invalid }
    end

    describe "discussion_topic" do
      subject { build(:discussion_post, discussion_topic: nil) }

      it { is_expected.to be_invalid }
    end

    describe "user" do
      subject { build(:discussion_post, user: nil) }

      it { is_expected.to be_invalid }
    end
  end
end
