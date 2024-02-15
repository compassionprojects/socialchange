class Category < ApplicationRecord
  extend Mobility

  # We keep two scopes here, one with kept_stories and the other without any scope.
  # This helps us in the admin dashboard and while deleting categories which has already discarded stories.
  #
  has_many :stories, dependent: :nullify, inverse_of: :category
  has_many :kept_stories, -> { kept }, dependent: :nullify, inverse_of: :category, class_name: "Story"

  has_ancestry

  translates :name
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  # Delete discarded stories when a category is deleted. Otherwise a category can't be destroyed.
  #
  before_destroy :check_for_stories

  private

  def check_for_stories
    if kept_stories.empty?
      stories.discarded.map(&:really_destroy!)
    end

    throw(:abort)
  end
end
