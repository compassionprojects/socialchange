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

    describe "role" do
      subject { create(:user, role: :author) }

      it "validates role" do
        expect { subject }.to raise_error(/is not a valid role/i)
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
end
