require 'rails_helper'

RSpec.describe Post, type: :model do
  fixtures :users, :posts, :comments
  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title).with_message('Title cannot be blank') }
    it {
      should validate_length_of(:title).is_at_most(250).with_message('Title exceeds the maximum length of 250 characters')
    }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#recent_comments' do
    let(:post) { posts(:one) }

    it 'returns the most recent comments first' do
      recent_comments = post.recent_comments
      expect(recent_comments.map(&:text)).to eq(['text comment 1', 'text comment 2', 'text comment 3',
                                                 'text comment 4', 'text comment 5'])
    end

    it 'returns a limited number of recent comments' do
      # Assuming post_one has many comments, test limiting the count
      expect(post.recent_comments(1).count).to eq(1)
    end
  end

  describe '#increment_comments_counter' do
    let(:post) { posts(:two) }

    it 'increments the comments_counter by 1' do
      expect { post.increment_comments_counter }.to change { post.comments_counter }.by(1)
    end
  end

  describe '#increment_likes_counter' do
    let(:post) { posts(:two) }

    it 'increments the likes_counter by 1' do
      expect { post.increment_likes_counter }.to change { post.likes_counter }.by(1)
    end
  end
end
