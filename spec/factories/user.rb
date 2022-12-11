FactoryBot.define do
  factory :user do
    confirmed_at { Time.zone.today }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
  end
end
