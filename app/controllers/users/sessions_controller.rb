module Users
  class SessionsController < Devise::SessionsController
    # invisible_captcha only: [:create], scope: :user, honeypot: :dummie_hpot_field
    skip_forgery_protection only: [:new]

    def new
      super
    end
  end
end
