require "rails_helper"

describe User do
  describe "validations" do
    describe "email" do
      subject { create(:user, email: "test", password: "12345678", name: "abc") }

      it "is valid" do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        expect { subject }.to raise_error(/Email address is invalid/i)
        expect(User.count).to be 0
      end
    end

    describe "password" do
      subject { create(:user, email: "test@example.com", password: "1234567", name: "abc") }

      it "is atleast 8 characters" do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        expect { subject }.to raise_error(/Password is too short/i)
        expect(User.count).to be 0
      end
    end

    describe "name" do
      subject { create(:user, email: "test@example.com", password: "12345678") }

      it "validates presence of name" do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        expect { subject }.to raise_error(/name can't be blank/i)
        expect(User.count).to be 0
      end
    end

    describe "language" do
      subject { create(:user, language: :fr, name: "Test", email: "test@example.com", password: "12345678") }

      it "validates language" do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        expect { subject }.to raise_error(/language is not included in the list/i)
        expect(User.count).to be 0
      end
    end

    context "when valid" do
      subject { create(:user, name: "Test", email: "test@example.com", password: "12345678") }

      it "creates a user" do
        expect { subject }.not_to raise_error
        expect(User.count).to be 1
      end
    end
  end
end
