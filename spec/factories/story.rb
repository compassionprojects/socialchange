FactoryBot.define do
  factory :story do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(random_sentences_to_add: 30) }
    outcomes { Faker::Lorem.paragraph(random_sentences_to_add: 30) }
    source { Faker::Lorem.paragraph(random_sentences_to_add: 4) }

    user
    updater factory: :user
  end
end