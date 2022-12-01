class User < ApplicationRecord
  enum :role, admin: "admin", moderator: "moderator"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable, :lockable

  validates :name, presence: true
  validates :language, inclusion: { in: I18n.available_locales.map(&:to_s) }, allow_nil: true

  def language=(u)
    self["language"] = u.presence
  end
end
