class User < ApplicationRecord
    has_many :posts, foreign_key: "author_id"
    has_many :comments
    has_many :likes

    validates :name, presence: true
    validates :posts_counter, numericality: {
        only_integer: true,
        greater_than_or_equal_to: 0
    }

    def recent_posts
        all_posts = self.posts.order(created_at: :desc)
        recent_three = all_posts.take(3)
        [ recent_three ]
    end

    def increment_posts_counter
        self.increment!(:posts_counter)
    end

    def get_posts_counter
        self.posts.count
    end

    private
end
