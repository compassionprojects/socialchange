FactoryBot.define do
  factory :discussion do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(random_sentences_to_add: 30) }
    story

    user
    updater factory: :user
  end
end
