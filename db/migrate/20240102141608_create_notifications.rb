class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications, if_not_exists: true do |t|
      t.references :recipient, polymorphic: true, null: false
      t.string :type, null: false
      t.jsonb :params
      t.datetime :read_at

      t.timestamps
    end
    add_index :notifications, :read_at, if_not_exists: true
  end
end
