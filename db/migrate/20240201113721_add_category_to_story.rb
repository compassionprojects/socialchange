class AddCategoryToStory < ActiveRecord::Migration[7.1]
  def change
    add_reference :stories, :category, foreign_key: true, index: true
  end
end
