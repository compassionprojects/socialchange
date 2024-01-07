FactoryBot.define do
  factory :discussion do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(random_sentences_to_add: 30) }
    story

    user
    updater factory: :user

    factory :discussion_with_posts do
      transient do
        posts_count { 5 }
      end

      posts { build_list(:post, posts_count, discussion: instance) }
    end
  end
end
