require "administrate/field/base"

module Fields
  class RichText < Administrate::Field::Base
    def to_s
      data
    end

    def to_partial_path
      "/administrate/fields/rich_text/#{page}"
    end
  end
end
