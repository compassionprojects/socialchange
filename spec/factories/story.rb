FactoryBot.define do
  factory :story do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(random_sentences_to_add: 2) }
    outcomes { Faker::Lorem.paragraph(random_sentences_to_add: 2) }
    source { Faker::Lorem.paragraph(random_sentences_to_add: 2) }
    country { Faker::Address.country_code }
    category
    user
    updater factory: :user

    factory :story_with_category do
      add_attribute(:category_id) { create(:category).id }
    end
  end
end
