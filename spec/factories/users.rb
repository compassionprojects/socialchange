# This will guess the User class
FactoryBot.define do
  factory :user do
    confirmed_at { Date.today }
  end
end
