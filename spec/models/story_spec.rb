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

  describe "#has_translations?" do
    subject { build(:story) }

    it { is_expected.to respond_to(:has_translations?) }

    it "returns boolean depending on whether translation exists or not" do
      expect(subject.has_translations?(:en)).to be_truthy
      expect(subject.has_translations?(:nl)).not_to be_truthy
    end
  end

  describe "#has_translations?" do
    subject do
      Mobility.locale = :en
      build(:story)
    end

    it { is_expected.to respond_to(:has_translations?) }

    it "returns boolean depending on whether translation exists or not" do
      expect(subject.has_translations?(:en)).to be_truthy
      expect(subject.has_translations?(:nl)).not_to be_truthy
    end
  end

  describe "#missing_translations" do
    subject do
      Mobility.locale = :en
      build(:story)
    end

    it { is_expected.to respond_to(:missing_translations) }

    it "returns locales for which translations are missing" do
      expect(subject.missing_translations).to eql [:nl]
    end
  end

  describe "#translated_in" do
    subject do
      Mobility.locale = :en
      build(:story)
    end

    it { is_expected.to respond_to(:translated_in) }

    it "returns locales in which translations exist" do
      expect(subject.translated_in).to eql [:en]
    end
  end
end
