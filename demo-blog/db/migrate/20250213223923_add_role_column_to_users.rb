class AddRoleColumnToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :text, null: false, default: ""
  end
end
