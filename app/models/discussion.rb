# Discussion model
#
class Discussion < ApplicationRecord
  include Discard::Model

  belongs_to :user
  belongs_to :story
  belongs_to :updater, class_name: "User"
  has_many :posts

  validates :title, :description, presence: true

  # After a topic is discarded, discard it's posts
  #
  after_discard do
    posts.discard_all
  end

  after_undiscard do
    posts.undiscard_all
  end
end
