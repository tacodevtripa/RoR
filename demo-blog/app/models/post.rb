class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :comments
  has_many :likes

  def recent_comments(limit = 5)
    self.comments.order(created_at: :desc).limit(limit)
  end

  def increment_comments_counter
    self.increment!(:comments_counter)
  end

  def increment_likes_counter
    self.increment!(:likes_counter)
  end
end
