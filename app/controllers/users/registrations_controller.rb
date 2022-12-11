module Users
  class RegistrationsController < Devise::RegistrationsController
    def update
      authorize resource
      super
    end

    # https://github.com/heartcombo/devise/wiki/How-to:-Soft-delete-a-user-when-user-deletes-account
    def destroy
      authorize resource
      resource.discard
      Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      set_flash_message :notice, :destroyed
      yield resource if block_given?
      respond_with_navigational(resource) { redirect_to after_sign_out_path_for(resource_name) }
    end
  end
end
