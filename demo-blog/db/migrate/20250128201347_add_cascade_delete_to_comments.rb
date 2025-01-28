class AddCascadeDeleteToComments < ActiveRecord::Migration[8.0]
  def change
      # Modify the foreign key to include on_delete: :cascade
      remove_foreign_key :comments, :users  # Remove the existing foreign key
      add_foreign_key :comments, :users, on_delete: :cascade
  end
end
