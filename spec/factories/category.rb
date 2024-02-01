FactoryBot.define do
  factory :category do
    # since name is unique, make sure we don't get a duplicate
    sequence(:name) { |n| Faker::Book.genre + n.to_s }
  end
end
