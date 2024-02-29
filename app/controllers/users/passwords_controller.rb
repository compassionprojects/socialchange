module Users
  class PasswordsController < Devise::PasswordsController
    invisible_captcha only: [:create], scope: :user, honeypot: :dummie_hpot_field
  end
end
