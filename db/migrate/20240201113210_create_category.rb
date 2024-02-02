class CreateCategory < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.jsonb :name, null: false, default: {}
      t.timestamps
    end
  end
end
