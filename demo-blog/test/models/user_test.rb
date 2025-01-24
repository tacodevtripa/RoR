require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      name: "demo user",
      posts_counter: 0
    )
  end

  # Test validations
  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "should not be valid without a name" do
    @user.name = nil
    assert_not @user.valid?
    assert_includes @user.errors[:name], "can't be blank"
  end

  test "should not be valid with a negative posts_counter" do
    @user.posts_counter = -1
    assert_not @user.valid?
    assert_includes @user.errors[:posts_counter], "must be greater than or equal to 0"
  end

  test "should not be valid with a non-integer posts_counter" do
    @user.posts_counter = 1.5
    assert_not @user.valid?
    assert_includes @user.errors[:posts_counter], "must be an integer"
  end

  # Test associations
  test "should have many posts" do
    assert_respond_to @user, :posts
  end

  test "recent_posts should return the three most recent posts" do
    @user.save
    5.times do |i|
      Post.create!(
        author: @user,
        title: "Post #{i + 1}",
        text: "Text #{i + 1}",
        comments_counter: 0,
        likes_counter: 0,
        created_at: Time.now - i.hours
      )
    end

    recent_posts = @user.recent_posts
    assert_equal 3, recent_posts.first.size
    assert_equal "Post 1", recent_posts.first.first.title
  end

  # Test increment_posts_counter method
  test "increment_posts_counter should increase posts_counter by 1" do
    @user.save
    assert_difference -> { @user.reload.posts_counter }, 1 do
      @user.increment_posts_counter
    end
  end

  # Test get_posts_counter method
  test "get_posts_counter should return the count of posts" do
    @user.save
    Post.create!(author: @user, title: "Test Post 1", text: "demo text", comments_counter: 0, likes_counter: 0)
    Post.create!(author: @user, title: "Test Post 2", text: "demo text", comments_counter: 0, likes_counter: 0)
    assert_equal 2, @user.get_posts_counter
  end
end
