class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.jsonb :title, null: false, default: {}
      t.jsonb :description, null: false, default: {}
      t.jsonb :outcomes, default: {}
      t.jsonb :source, default: {}
      t.integer :status
      t.string :country
      t.date :start_date
      t.date :end_date
      t.references :user, null: false, foreign_key: true, index: true
      t.references :updater, null: false, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end

    add_index :stories, :title, :using => :gin
    add_index :stories, :description, :using => :gin
    add_index :stories, :outcomes, :using => :gin
    add_index :stories, :source, :using => :gin
  end
end
