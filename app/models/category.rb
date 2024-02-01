class Category < ApplicationRecord
  # only allow deleting a category if it has no stories
  has_many :stories, dependent: :restrict_with_exception
  validates :name, presence: true, uniqueness: true
end
