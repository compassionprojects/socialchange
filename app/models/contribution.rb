class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :story

  after_create_commit :invite_contributor, unless: -> { Rails.env.test? }

  private

  def invite_contributor
    InviteContributorNotification.with(story:).deliver_later([user])
  end
end
