require 'rails_helper'
RSpec.describe User, type: :model do
  fixtures :users, :posts
  describe "associations" do
    it { should have_many(:posts).with_foreign_key('author_id') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it {
      should validate_numericality_of(:posts_counter)
        .only_integer
        .is_greater_than_or_equal_to(0)
    }
  end

  describe '#recent_posts' do
  it 'returns the three most recent posts' do
    user = users(:one)  # Accessing the fixture for the user
    posts = posts(:one, :two, :three, :four, :five)  # Adjust to your fixture data
    user.posts = posts
    recent_posts = user.recent_posts

    expect(recent_posts.flatten.size).to eq(3)
    expect(recent_posts.flatten).to eq(user.posts.order(created_at: :desc).limit(3))
  end
end

  describe '#increment_posts_counter' do
    it 'increments the posts_counter by 1' do
      user = users(:one)
      expect { user.increment_posts_counter }.to change { user.posts_counter }.by(1)
    end
  end

  describe '#get_posts_counter' do
    it 'returns the correct count of posts associated with the user' do
      user = users(:one)
      posts = posts(:one, :two, :three, :four, :five)  # Adjust to your fixture data
      user.posts = posts
      expect(user.get_posts_counter).to eq(5)
    end
  end
end
