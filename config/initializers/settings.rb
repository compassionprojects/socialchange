class Settings
  class << self
    def contact_email
      ENV["DOMAIN_EMAIL_ADDRESS"]
    end
  end
end
