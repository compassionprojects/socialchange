class CreatePreferences < ActiveRecord::Migration[7.0]
  def change
    create_table :preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :notify_new_discussion_on_story, null: false, default: true
      t.boolean :notify_new_post_on_discussion, null: false, default: true
      t.boolean :notify_any_post_in_discussion, null: false, default: true
      t.boolean :notify_new_story, null: false, default: false

      t.timestamps
    end
  end
end
