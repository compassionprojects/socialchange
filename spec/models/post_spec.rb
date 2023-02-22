require "rails_helper"

describe Post do
  describe "validations" do
    describe "body" do
      subject { build(:post, body: nil) }

      it { is_expected.to be_invalid }
    end

    describe "discussion" do
      subject { build(:post, discussion: nil) }

      it { is_expected.to be_invalid }
    end

    describe "user" do
      subject { build(:post, user: nil) }

      it { is_expected.to be_invalid }
    end
  end
end
