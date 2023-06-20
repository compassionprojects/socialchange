class CreateStoryUpdate < ActiveRecord::Migration[7.0]
  def change
    create_table :story_updates do |t|
      t.jsonb :title, null: false, default: {}
      t.jsonb :description, null: false, default: {}
      t.references :story, null: false, foreign_key: true, index: true
      t.references :user, null: false, foreign_key: true, index: true
      t.references :updater, null: false, foreign_key: {to_table: :users}, index: true
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
