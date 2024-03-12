# The Settings class is a singleton class which holds all configuration
# which is accessed throughout the application outside of `config` files.
# These settings mostly include environemt variables and other global settings.
#
# Similar pattern and inspiration from:
# https://garrettdimon.com/journal/posts/unified-configuration-in-rails
#
# Usage: Settings.instance.contact_email
#

class Settings
  include Singleton

  def contact_email
    ENV["DOMAIN_EMAIL_ADDRESS"]
  end
end
