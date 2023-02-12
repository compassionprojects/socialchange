FactoryBot.define do
  factory :discussion_post do
    body { Faker::Lorem.paragraph(random_sentences_to_add: 30) }
    discussion_topic

    user
    updater factory: :user
  end
end
