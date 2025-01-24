class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.integer :author_id, null: false
      t.string :title, null: false
      t.text :text, null: false
      t.integer :comments_counter, default: 0
      t.integer :likes_counter, default: 0

      t.timestamps
    end

    add_foreign_key :posts, :users, column: :author_id
  end
end
