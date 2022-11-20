require 'rails_helper'

describe User do
  describe 'validations' do
    context 'when name is empty' do
      subject { create(:user) }

      it 'should not create a new user and raise validation errors' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        expect(User.count).to be 0
      end
    end
  end
end
