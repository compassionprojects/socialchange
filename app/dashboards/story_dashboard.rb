require "administrate/base_dashboard"

class StoryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  #
  # @todo consider adding jsonb type so that all attributes are editable
  # in admin interface
  # https://github.com/codica2/administrate-field-jsonb
  #
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    country: Field::String,
    description: MobilityTextField.with_options(searchable: true),
    end_date: Field::Date,
    outcomes: MobilityTextField.with_options(searchable: true),
    source: MobilityTextField.with_options(searchable: true),
    start_date: Field::Date,
    status: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }, include_blank: true),
    title: MobilityStringField.with_options(searchable: true),
    updater: Field::BelongsTo,
    user: Field::BelongsTo,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    title
    user
    created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    title
    description
    status
    outcomes
    source
    country
    start_date
    end_date
    updater
    user
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    title
    description
    status
    outcomes
    source
    country
    start_date
    end_date
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {
    # Add language filters
    # unfortunately administrate doesn't support `lang:en,nl`
    # i.e, it doesn't take comma separated values, so array.split(",") is not
    # necessary below, however, this would be a "nice to have", so we leave it as is
    lang: -> (resources, attrs) { resources.where("title ?& array[:keys]", keys: attrs.split(",")) },

    # Status filters for "draft" or "published"
    status: ->(resources, attrs) { resources.where(status: attrs) },
  }.freeze

  # Overwrite this method to customize how stories are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(story)
  #   "Story ##{story.id}"
  # end
end
