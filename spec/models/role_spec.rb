require "rails_helper"

describe Role do
  subject { build(:role) }

  describe "validations" do
    it { is_expected.to be_invalid }

    context "when valid" do
      subject { build(:role, name: "Admin") }

      it { is_expected.to be_valid }
    end
  end
end
