class DropNotifications < ActiveRecord::Migration[7.1]
  def change
    remove_index :notifications, :read_at, if_not_exists: true
    drop_table :notifications, if_exists: true do |t|
      t.references :recipient, polymorphic: true, null: false
      t.string :type, null: false
      t.jsonb :params
      t.datetime :read_at

      t.timestamps
    end
  end
end
