require "rails_helper"

describe Contribution, type: :model do
  describe "validations" do
    describe "user" do
      subject { build(:contribution, user: nil) }

      it { is_expected.to be_invalid }
    end

    describe "story" do
      subject { build(:contribution, story: nil) }

      it { is_expected.to be_invalid }
    end

    context "when valid" do
      subject { build(:contribution) }

      it { is_expected.to be_valid }
    end
  end

  describe "associations" do
    describe "user" do
      subject { build(:contribution).user }

      it { is_expected.to be_a User }
    end

    describe "story" do
      subject { build(:contribution).story }

      it { is_expected.to be_a Story }
    end
  end
end
