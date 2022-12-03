require "administrate/field/base"

module Fields
  module Mobility
    class Text < Administrate::Field::Base
      def to_s
        data
      end

      # We permit localized attributes like title_en, title_nl to update
      # using mobility helpers
      #
      def self.permitted_attribute(attribute, _options = nil)
        I18n.available_locales.map do |locale|
          "#{attribute}_#{locale}".downcase.underscore
        end
      end

      def to_partial_path
        "/administrate/fields/mobility/text/#{page}"
      end
    end
  end
end
