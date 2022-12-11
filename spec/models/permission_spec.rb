require "rails_helper"

describe Permission do
  subject { build(:permission) }

  describe "validations" do
    it { is_expected.to be_invalid  }

    context "with invalid name" do
      subject { build(:permission, name: "abc") }
      it { is_expected.to be_invalid  }
    end

    context "with valid name" do
      subject { build(:permission, name: "users.manage") }
      it { is_expected.to be_valid  }
    end
  end
end
