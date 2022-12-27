FactoryBot.define do
  factory :story_update do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(random_sentences_to_add: 30) }
    user
    updater factory: :user
    story factory: :story
  end
end
