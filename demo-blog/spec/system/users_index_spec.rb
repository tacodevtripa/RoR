require 'rails_helper'

RSpec.describe 'Users Index Page', type: :system do
  fixtures :users # Loads the users fixture

  before do
    driven_by(:rack_test)
    visit root_path
  end

  it 'displays all users with their names' do
    expect(page).to have_link(users(:one).name, href: show_user_path(users(:one)))
    expect(page).to have_link(users(:two).name, href: show_user_path(users(:two)))
  end

  it 'displays the profile photo for users who have one' do
    user_with_photo = users(:one)
    expect(page).to have_css("img[alt='#{user_with_photo.name} profile picture']")
  end

  it 'shows "No photo" text for users without a profile photo' do
    users(:two)
    expect(page).to have_content('No photo')
  end

  it 'shows the number of posts for each user' do
    expect(page).to have_content("Number of Posts: #{users(:one).posts_counter}")
    expect(page).to have_content("Number of Posts: #{users(:two).posts_counter}")
  end

  it 'redirects to the user show page when clicking on a user' do
    user = users(:one)

    # Click on the user's name link
    click_link user.name

    # Expect to be redirected to the user's show page
    expect(page).to have_current_path(show_user_path(user))

    expect(page).to have_content(user.name)
    expect(page).to have_content("Test Bio")
  end
end
