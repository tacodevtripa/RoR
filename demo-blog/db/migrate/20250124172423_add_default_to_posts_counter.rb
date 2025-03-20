class AddDefaultToPostsCounter < ActiveRecord::Migration[8.0]
  def change
    change_column :users, :posts_counter, :integer, default: 0
  end
end
