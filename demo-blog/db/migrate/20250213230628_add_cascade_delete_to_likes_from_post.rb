class AddCascadeDeleteToLikesFromPost < ActiveRecord::Migration[8.0]
  def change
      # Modify the foreign key to include on_delete: :cascade
      remove_foreign_key :likes, :posts  # Remove the existing foreign key
      add_foreign_key :likes, :posts, on_delete: :cascade
  end
end
