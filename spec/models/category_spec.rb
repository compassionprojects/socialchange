require "rails_helper"

describe Category, type: :model do
  describe "validations" do
    describe "name" do
      subject { build(:category, name: nil) }

      it { is_expected.to be_invalid }
    end

    context "when name is not unique" do
      let!(:category) { create(:category) }
      subject { build(:category, name: category.name) }

      it { is_expected.to be_invalid }
    end

    context "when valid" do
      subject { build(:category) }

      it { is_expected.to be_valid }
    end
  end

  describe "associations" do
    describe "stories" do
      subject { create(:category).stories }

      it { is_expected.to be_empty }
    end
  end
end
