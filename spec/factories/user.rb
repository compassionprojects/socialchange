# User factory
#
FactoryBot.define do
  factory :user do
    confirmed_at { Time.zone.today }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }

    factory :user_with_stories do
      transient do
        stories_count { 5 }
      end

      stories do
        Array.new(stories_count) { association(:story, user: instance, updater: instance) }
      end
    end
  end
end
