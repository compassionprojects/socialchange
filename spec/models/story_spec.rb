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
end
