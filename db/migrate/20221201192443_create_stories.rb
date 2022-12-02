class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.jsonb :title, null: false
      t.jsonb :description, null: false
      t.jsonb :outcomes
      t.jsonb :source
      t.integer :status
      t.string :country
      t.date :start_date
      t.date :end_date
      t.references :user, null: false, foreign_key: true, index: true
      t.references :updater, null: false, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end
  end
end
