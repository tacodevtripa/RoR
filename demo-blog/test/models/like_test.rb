require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(
      name: 'Test User',
      posts_counter: 0
    )
    @post = Post.create!(
      author: @user,
      title: 'Test Post',
      text: 'Test Text',
      comments_counter: 0,
      likes_counter: 0
    )
    @like = Like.new(
      user: @user,
      post: @post
    )
  end
  test 'should belong to an user' do
    assert_respond_to @like, :user
  end

  test 'should belong to a post' do
    assert_respond_to @like, :post
  end
end
