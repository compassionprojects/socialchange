FactoryBot.define do
  factory :discussion_topic do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(random_sentences_to_add: 30) }
    story

    user
    updater factory: :user
  end
end
