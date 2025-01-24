class User < ApplicationRecord
    has_many :posts, foreign_key: "author_id"
    has_many :comments
    has_many :likes

    def recent_posts
        all_posts = self.posts.order(created_at: :desc)
        recent_three = all_posts.take(3)
        [ recent_three ]
    end

    private
end
