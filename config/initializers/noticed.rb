module Noticed
  class Base
    def default_url_options
      {lang: I18n.locale}
    end
  end
end
