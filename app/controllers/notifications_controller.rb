class NotificationsController < ApplicationController
  before_action :authenticate_user!

  after_action :mark_notifications_as_read, only: :index
  def index
    @notifications = current_user.notifications.includes(:event).newest_first
  end

  private

  def mark_notifications_as_read
    current_user.notifications.mark_as_read
  end
end
