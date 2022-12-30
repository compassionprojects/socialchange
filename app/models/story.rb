# Story model
#
class Story < ApplicationRecord
  extend Mobility
  include Discard::Model

  belongs_to :user
  belongs_to :updater, class_name: "User"
  has_many :story_updates, -> { kept.order(created_at: :asc) }, dependent: :destroy, inverse_of: :story

  enum :status, %i[draft published]

  translates :title, :description, :outcomes, :source

  validates :title, :description, :country, presence: true

  scope :published, -> { where("stories.title ? '#{I18n.locale}'").and(where("stories.description ? '#{I18n.locale}'")) }

  # After a story is discarded, discard it's updates
  #
  after_discard do
    story_updates.discard_all
  end

  after_undiscard do
    story_updates.undiscard_all
  end

  # https://github.com/countries/country_select#getting-the-country-name-from-the-countries-gem
  # Assuming country_select is used with User attribute `country`
  # This will attempt to translate the country name and use the default
  # (usually English) name if no translation is available
  #
  def country_name
    return unless country
    c = ISO3166::Country[country]
    c.translations[I18n.locale.to_s] || c.common_name || c.iso_short_name
  end
end
