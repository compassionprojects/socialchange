class CreateRolesAndPermissions < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :role, :string

    create_table :roles do |t|
      t.string      :name, null: false
      t.timestamps
    end

    create_table :permissions do |t|
      t.string      :name, null: false
      t.timestamps
    end

    create_table :permissions_roles, primary_key: [:role_id, :permission_id] do |t|
      t.references  :role, null: false
      t.references  :permission, null: false
    end

    create_table :roles_users, primary_key: [:user_id, :role_id] do |t|
      t.references  :user, null: false
      t.references  :role, null: false
    end

    add_index :permissions_roles, [:role_id, :permission_id], unique: true
  end
end
