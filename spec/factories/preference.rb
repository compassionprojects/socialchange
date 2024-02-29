FactoryBot.define do
  factory :preference do
    user
    notify_new_story { false }
    notify_new_discussion_on_story { true }
    notify_new_post_on_discussion { true }
    notify_any_post_in_discussion { true }
  end
end
