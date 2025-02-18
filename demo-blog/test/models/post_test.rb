require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(
      name: 'Test User',
      posts_counter: 0
    )
    @post = Post.new(
      author: @user,
      title: 'Test Post',
      text: 'Test Text',
      comments_counter: 0,
      likes_counter: 0
    )
  end

  # Test validations
  test 'should be valid with valid attributes' do
    assert @post.valid?
  end

  test 'should not be valid without a title' do
    @post.title = nil
    assert_not @post.valid?
    assert_includes @post.errors[:title], 'Title cannot be blank'
  end

  test 'should not be valid if title exceeds 250 characters' do
    @post.title = 'a' * 251
    assert_not @post.valid?
    assert_includes @post.errors[:title], 'Title exceeds the maximum length of 250 characters'
  end

  test 'should not be valid with a negative comments_counter' do
    @post.comments_counter = -1
    assert_not @post.valid?
    assert_includes @post.errors[:comments_counter], 'must be greater than or equal to 0'
  end

  test 'should not be valid with a non-integer comments_counter' do
    @post.comments_counter = 1.5
    assert_not @post.valid?
    assert_includes @post.errors[:comments_counter], 'must be an integer'
  end

  test 'should not be valid with a negative likes_counter' do
    @post.likes_counter = -1
    assert_not @post.valid?
    assert_includes @post.errors[:likes_counter], 'must be greater than or equal to 0'
  end

  test 'should not be valid with a non-integer likes_counter' do
    @post.likes_counter = 1.5
    assert_not @post.valid?
    assert_includes @post.errors[:likes_counter], 'must be an integer'
  end

  # Test associations
  test 'should belong to an author' do
    assert_respond_to @post, :author
  end

  test 'should have many comments' do
    assert_respond_to @post, :comments
  end

  test 'should have many likes' do
    assert_respond_to @post, :likes
  end

  # Test recent_comments method
  test 'recent_comments should return the most recent comments' do
    @post.save
    7.times do |i|
      Comment.create!(
        post: @post,
        user: @user,
        text: "Comment #{i + 1}",
        created_at: Time.now - i.hours
      )
    end

    recent_comments = @post.recent_comments
    assert_equal 5, recent_comments.size
    assert_equal 'Comment 1', recent_comments.first.text
  end

  # Test increment_comments_counter method
  test 'increment_comments_counter should increase comments_counter by 1' do
    @post.save
    assert_difference -> { @post.reload.comments_counter }, 1 do
      @post.increment_comments_counter
    end
  end

  # Test increment_likes_counter method
  test 'increment_likes_counter should increase likes_counter by 1' do
    @post.save
    assert_difference -> { @post.reload.likes_counter }, 1 do
      @post.increment_likes_counter
    end
  end
end
