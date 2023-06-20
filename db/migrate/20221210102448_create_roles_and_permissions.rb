class CreateRolesAndPermissions < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :role, :string

    create_table :roles do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :permissions do |t|
      t.string :name, null: false
      t.timestamps
    end

    # standard:disable Rails/CreateTableWithTimestamps
    create_table :permissions_roles, primary_key: %i[role_id permission_id] do |t|
      t.references :role, null: false
      t.references :permission, null: false
    end

    create_table :roles_users, primary_key: %i[user_id role_id] do |t|
      t.references :user, null: false
      t.references :role, null: false
    end
    # standard:enable Rails/CreateTableWithTimestamps

    add_index :permissions_roles, %i[role_id permission_id], unique: true
  end
end
