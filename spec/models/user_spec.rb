require "rails_helper"

describe User do
  describe "validations" do
    describe "name" do
      subject { create(:user, email: "test@example.com", password: "12345678") }

      it "should not create a new user and raise validation errors" do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        expect { subject }.to raise_error(/name can't be blank/i)
        expect(User.count).to be 0
      end
    end

    describe "language" do
      subject { create(:user, language: :fr, name: "Test", email: "test@example.com", password: "12345678") }

      it "should not create a new user and raise validation errors" do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        expect { subject }.to raise_error(/language is not included in the list/i)
        expect(User.count).to be 0
      end
    end
  end
end
