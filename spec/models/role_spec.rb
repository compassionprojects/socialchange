require "rails_helper"

describe Role do
  subject { build(:role) }

  describe "validations" do
    it { is_expected.to be_invalid }
  end
end
