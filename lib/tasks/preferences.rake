namespace :preferences do
  desc "Create missing preferences for users"
  task create_missing_preferences: :environment do
    User.find_each do |user|
      user.create_preference unless user.preference && user.confirmed?
    end
  end
end
