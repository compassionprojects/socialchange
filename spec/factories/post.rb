FactoryBot.define do
  factory :post do
    body { Faker::Lorem.paragraph(random_sentences_to_add: 30) }
    discussion

    user
    updater factory: :user
  end
end
