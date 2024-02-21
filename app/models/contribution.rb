class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :story, touch: true

  after_create_commit :invite_contributor, unless: -> { Rails.env.test? }

  private

  def invite_contributor
    InviteContributorNotifier.with(record: user, story:).deliver_later([user])
  end
end
