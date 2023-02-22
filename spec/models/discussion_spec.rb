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
end
