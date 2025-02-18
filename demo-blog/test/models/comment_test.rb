require 'test_helper'

class CommentTest < ActiveSupport::TestCase
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
    @comment = Comment.new(
      user: @user,
      post: @post,
      text: 'test comment'
    )
  end
  test 'should belong to an user' do
    assert_respond_to @comment, :user
  end

  test 'should belong to a post' do
    assert_respond_to @comment, :post
  end
end
