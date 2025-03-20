require 'rails_helper'

RSpec.describe 'User Show Posts Page', type: :system do
  fixtures :users, :posts, :comments # Load users and posts from fixtures

  let(:user) { users(:one) }

  before do
    driven_by(:rack_test)
    visit show_user_posts_path(user.id, page: 1)
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

  it 'displays the title of a post' do
    expect(page).to have_content(posts(:one).title)
  end

  it 'displays the body of a post' do
    expect(page).to have_content(posts(:one).text)
  end

  it 'displays the last 5 comments of a post' do
    expect(page).to have_content(comments(:one).text)
    expect(page).to have_content(comments(:two).text)
    expect(page).to have_content(comments(:three).text)
    expect(page).to have_content(comments(:four).text)
    expect(page).to have_content(comments(:five).text)
  end

  it 'displays the number of comments a post has' do
    expect(page).to have_content("Comments: #{posts(:one).comments_counter}")
  end

  it 'displays the number of likes a post has' do
    expect(page).to have_content("Likes: #{posts(:one).likes_counter}")
  end

  it 'displays the pagination element if user has more than 3 posts' do
    expect(page).to have_css("ul[class='pagination']")
  end

  it 'redirects to the post view page when clicking on the `view post` button' do
    click_link 'view post', match: :first

    expect(page).to have_current_path(show_user_specific_post_path(user.id, posts(:one).id))
    expect(page).to have_content(posts(:one).text)
  end
end
