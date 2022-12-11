class AddIndexToRoleAndPermissionNames < ActiveRecord::Migration[7.0]
  def change
    add_index :roles, :name, unique: true
    add_index :permissions, :name, unique: true
  end
end
