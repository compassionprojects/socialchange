require "administrate/field/base"

class MobilityStringField < Administrate::Field::Base
  def to_s
    data
  end

  def self.permitted_attribute(attribute, _options = nil)
    I18n.available_locales.map do |locale|
      "#{attribute}_#{locale}".downcase.underscore
    end
  end
end
