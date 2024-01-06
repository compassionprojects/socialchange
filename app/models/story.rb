# Story model
#
class Story < ApplicationRecord
  extend Mobility
  include Discard::Model
  include Translatable

  belongs_to :user
  belongs_to :updater, class_name: "User"
  has_many :story_updates, -> { kept.order(created_at: :asc) }, dependent: :destroy, inverse_of: :story
  has_many :discussions, dependent: :destroy # @todo: add inverse_of and default order
  has_many_attached :documents

  after_create_commit :notify

  # @todo: remove status
  enum :status, %i[draft published]

  translates :title, :description, :outcomes, :source

  validates :title, :description, :country, presence: true

  # After a story is discarded, discard it's updates and discussions
  #
  after_discard do
    story_updates.discard_all
    discussions.discard_all
  end

  after_undiscard do
    story_updates.undiscard_all
    discussions.undiscard_all
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[title description outcomes source country]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[story_updates]
  end

  # https://github.com/countries/country_select#getting-the-country-name-from-the-countries-gem
  # Assuming country_select is used with User attribute `country`
  # This will attempt to translate the country name and use the default
  # (usually English) name if no translation is available
  #
  def country_name
    return unless country.presence

    c = ISO3166::Country[country]
    c.translations[I18n.locale.to_s] || c.common_name || c.iso_short_name
  end

  private

  def notify
    NewStoryNotification.with(story: self).deliver_later(User.with_notify_new_story_preference)
  end
end
