module Users
  class RegistrationsController < Devise::RegistrationsController
    def update
      authorize resource
      super
    end
  end
end
