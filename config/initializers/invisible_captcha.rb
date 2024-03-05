# Invisible Captcha configuration
# https://github.com/markets/invisible_captcha?tab=readme-ov-file#plugin-options
#
InvisibleCaptcha.setup do |config|
  # Set threshold to 0s on test environment and otherwise 3s
  config.timestamp_threshold = Rails.env.test? ? 0 : 3
end
