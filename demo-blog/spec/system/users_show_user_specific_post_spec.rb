require 'rails_helper'

RSpec.describe 'User Show Specific Post Page', type: :system do
  fixtures :users, :posts, :comments # Load users and posts from fixtures

  let(:user) { users(:one) }
  let(:post) { posts(:one) }

  before do
    driven_by(:rack_test)
    visit show_user_specific_post_path(user.id, post.id)
  end

  it "displays the user's username" do
    expect(page).to have_content("by #{user.name}")
  end

  it 'displays the title of a post' do
    expect(page).to have_content(post.title)
  end

  it 'displays the body of the post' do
    expect(page).to have_content(post.text)
  end

  it 'displays the last 5 comments of a post' do
    post.comments.each do |comment|
      expect(page).to have_content(user.name)
      expect(page).to have_content(comment.text)
    end
  end

  it 'displays the number of comments a post has' do
    expect(page).to have_content("Comments: #{post.comments_counter}")
  end

  it 'displays the number of likes a post has' do
    expect(page).to have_content("Likes: #{post.likes_counter}")
  end
end
