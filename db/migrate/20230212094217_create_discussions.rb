class CreateDiscussions < ActiveRecord::Migration[7.0]
  def change
    create_table :discussions do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.references :story, null: false, foreign_key: true, index: true
      t.references :user, null: false, foreign_key: true, index: true
      t.references :updater, null: false, foreign_key: {to_table: :users}, index: true
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
