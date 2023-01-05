module Translatable
  extend ActiveSupport::Concern

  included do
    def translation?(locale)
      Mobility.with_locale(locale) do
        (title(fallback: false) && description(fallback: false)).presence
      end
    end

    def missing_translations
      I18n.available_locales.filter { |l| !translation?(l) }
    end

    def translated_in
      I18n.available_locales.filter { |l| translation?(l) }
    end
  end
end
