class RemoveStatusFromStory < ActiveRecord::Migration[7.1]
  def change
    remove_column :stories, :status, :integer
  end
end
