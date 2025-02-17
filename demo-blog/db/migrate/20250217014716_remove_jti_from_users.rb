class RemoveJtiFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_index :users, :jti # Remove the index on the jti column
    remove_column :users, :jti # Remove the jti column
  end
end
