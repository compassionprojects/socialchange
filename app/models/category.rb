class Category < ApplicationRecord
  extend Mobility

  # only allow deleting a category if it has no stories
  has_many :stories, dependent: :restrict_with_exception

  translates :name
  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
