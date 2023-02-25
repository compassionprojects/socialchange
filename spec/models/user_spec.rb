require "rails_helper"

describe User do
  describe "validations" do
    describe "email" do
      subject { create(:user, email: "test") }

      it "is invalid" do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        expect { subject }.to raise_error(/Email address is invalid/i)
        expect(described_class.count).to be 0
      end
    end

    describe "password" do
      subject { create(:user, password: "1234567") }

      it "is atleast 8 characters" do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        expect { subject }.to raise_error(/Password is too short/i)
        expect(described_class.count).to be 0
      end
    end

    describe "name" do
      subject { create(:user, name: nil) }

      it "validates presence of name" do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        expect { subject }.to raise_error(/name can't be blank/i)
        expect(described_class.count).to be 0
      end
    end

    describe "language" do
      subject { create(:user, language: :fr) }

      it "validates language" do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        expect { subject }.to raise_error(/language is not included in the list/i)
        expect(described_class.count).to be 0
      end
    end

    context "when valid" do
      subject { create(:user) }

      it "creates a user" do
        expect { subject }.not_to raise_error
        expect(described_class.count).to be 1
      end
    end
  end

  describe "discard" do
    let(:user) { create(:user) }

    it "discards all associated records" do
      create_list(:story, 3, user:)
      create_list(:discussion, 3, user:)
      create_list(:post, 3, user:)

      # Check if the record first exist
      expect(Story.kept.where(user:)).not_to be_empty
      expect(Discussion.kept.where(user:)).not_to be_empty
      expect(Post.kept.where(user:)).not_to be_empty

      user.discard

      # Check if the records are discarded after .discard
      expect(user.discarded_at).not_to be_nil
      expect(Story.kept.where(user:)).to be_empty
      expect(Discussion.kept.where(user:)).to be_empty
      expect(Post.kept.where(user:)).to be_empty
    end
  end
end
