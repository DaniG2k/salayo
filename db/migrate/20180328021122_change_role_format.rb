class ChangeRoleFormat < ActiveRecord::Migration[5.1]
  def change
    drop_table :users_roles
    drop_table :roles

    add_column :users, :role, :integer, default: 1, null: false
  end
end
