class Role < ApplicationRecord
  has_and_belongs_to_many :permissions, timestamps: false
  has_and_belongs_to_many :users, timestamps: false

  validates :name, presence: true, uniqueness: true
end
