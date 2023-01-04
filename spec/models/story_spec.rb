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

  describe "#translation?" do
    subject do
      Mobility.locale = :en
      build(:story)
    end

    it { is_expected.to have_translation(:en) }
    it { is_expected.not_to have_translation(:nl) }
  end

  describe "#missing_translations" do
    subject(:story) do
      Mobility.locale = :en
      build(:story)
    end

    it { is_expected.to respond_to(:missing_translations) }

    it "returns locales for which translations are missing" do
      expect(story.missing_translations).to eql [:nl]
    end
  end

  describe "#translated_in" do
    subject(:story) do
      Mobility.locale = :en
      build(:story)
    end

    it { is_expected.to respond_to(:translated_in) }

    it "returns locales in which translations exist" do
      expect(story.translated_in).to eql [:en]
    end
  end
end
