# Story model
#
class Story < ApplicationRecord
  extend Mobility
  include Discard::Model
  include Translatable

  MAX_CONTRIBUTORS = 4

  belongs_to :category
  belongs_to :user
  belongs_to :updater, class_name: "User"
  has_many :story_updates, -> { kept.order(created_at: :asc) }, dependent: :destroy, inverse_of: :story
  has_many :discussions, dependent: :destroy # @todo: add inverse_of and default order
  has_many_attached :documents
  has_many :contributions, dependent: :destroy
  has_many :contributors, through: :contributions, source: :user
  has_many :noticed_events, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  has_many :notifications, through: :noticed_events, class_name: "Noticed::Notification"

  after_create_commit :notify

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

  # Invite contributors to the story
  # @param [Array<String>] emails
  # @param [User] inviter
  # - Skip if user is already a contributor, inviter, or the story owner
  # - If the user is not confirmed, re-invite him
  # - If the user doesn't exist, create him with invitation and skip invitation email (let contribution hooks send the email)
  # - Add the user as a contributor if they are not already
  # - Make sure inviter is a contributor or the story owner
  #
  def invite_contributors(emails, inviter = nil)
    # Make sure inviter is a contributor or the story owner
    # @todo use policy
    raise StandardError, "Inviter must be a contributor or the owner of the story" if !invitable?(inviter)

    # Validate emails
    # And add limit
    limit = MAX_CONTRIBUTORS - contributors.length
    emails.map(&:strip).uniq.select { |e| e =~ Devise.email_regexp }.take(limit).each do |email|
      user = User.find_by(email:)

      # Skip if the user is already a contributor, the inviter, or the story owner
      next if (user&.confirmed? && contributed?(user)) || user == inviter || user == self.user

      # If the user is not confirmed, re-invite them
      if user
        user.invite! unless user.confirmed?
      else
        # If the user doesn't exist, invite them
        user = User.invite!({email:}, inviter) { |u| u.skip_invitation = true }
      end

      # Add the user as a contributor if they are not already
      contributions.create(user:) unless contributed?(user)
    end
  end

  def invitable?(inviter)
    inviter && (contributed?(inviter) || inviter == user) && contributors.length < MAX_CONTRIBUTORS
  end

  def contributed?(user)
    contributors.any? { |u| u.id == user.id }
  end

  def confirmed_contributors
    contributors.filter { |u| u.confirmed? }
  end

  private

  def notify
    NewStoryNotifier.with(record: self).deliver_later(User.with_notify_new_story_preference)
  end
end
