# User model
#
class User < ApplicationRecord
  include Discard::Model

  has_and_belongs_to_many :roles

  has_many :stories, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :posts, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable, :lockable

  validates :name, presence: true
  validates :language, inclusion: { in: I18n.available_locales.map(&:to_s) }, allow_nil: true

  # After a user is discarded, discard his stories
  #
  after_discard do
    stories.discard_all
  end

  after_undiscard do
    stories.undiscard_all
  end

  def language=(u)
    self["language"] = u.presence
  end

  def has_permission?(action, resource) # rubocop:disable Naming/PredicateName
    permissions.include?("#{resource}.#{action}")
  end

  def permissions
    @permissions ||= roles.flat_map(&:permissions).map(&:name).uniq
  end

  def active_for_authentication?
    super && !discarded?
  end
end
