class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  validates :name, presence: true
  validates :posts_counter, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  def recent_posts
    all_posts = posts.order(created_at: :desc)
    all_posts.take(3)
  end

  def increment_posts_counter
    increment!(:posts_counter)
  end

  def see_posts_counter
    posts.count
  end
end
