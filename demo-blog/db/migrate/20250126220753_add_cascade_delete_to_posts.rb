class AddCascadeDeleteToPosts < ActiveRecord::Migration[8.0]
  def change
    # Modify the foreign key to include on_delete: :cascade
    remove_foreign_key :posts, :users  # Remove the existing foreign key
    add_foreign_key :posts, :users, column: :author_id, on_delete: :cascade
  end
end
