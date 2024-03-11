class Settings
  include Singleton

  def contact_email
    ENV["DOMAIN_EMAIL_ADDRESS"]
  end
end
