# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    include Administrate::Punditize

    before_action :authenticate_admin

    def authenticate_admin
      redirect_to "/" unless user_signed_in? && can_manage_resource?
    end

    # Allow user to enter admin if he has one of the .list or .manage permissions
    def can_manage_resource?
      current_user.permissions.any? { |str| str.include?(".list") || str.include?(".manage") }
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
