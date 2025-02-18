require 'rails_helper'

RSpec.describe 'User Show Page', type: :system do
  fixtures :users, :posts # Load users and posts from fixtures

  let(:user) { users(:one) }

  before do
    driven_by(:rack_test)
    visit show_user_path(user)
  end

  it 'displays the user’s profile photo or alt text' do
    expect(page).to have_css("img[alt='#{user.name} profile picture']")
  end

  it "displays the user's username" do
    expect(page).to have_content(user.name)
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_content("Number of Posts: #{user.posts_counter}")
  end

  it "displays the user's bio" do
    expect(page).to have_content(user.bio)
  end

  it "displays the user's last 3 posts" do
    user.recent_posts.each do |post|
      expect(page).to have_content(post.text)
    end
  end

  it "redirects to the post's show page when clicking on a post" do
    post = user.recent_posts.first
    click_link 'view post', match: :first

    expect(page).to have_current_path(show_user_specific_post_path(user.id, post.id))
    expect(page).to have_content(post.text)
  end

  it "redirects to the user's posts index page when clicking on 'show all posts' button" do
    click_link 'See All Posts', match: :first

    expect(page).to have_current_path(show_user_posts_path(user.id, page: 1))
    expect(page).to have_content("#{user.name}'s Posts")
  end
end
