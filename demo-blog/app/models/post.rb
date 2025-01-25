class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :comments
  has_many :likes

  validates :title, presence: { message: "Title cannot be blank" }
  validates :title, length: { maximum: 250, message: "Title exceeds the maximum length of 250 characters" }

  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

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
