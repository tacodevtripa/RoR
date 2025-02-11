require 'rails_helper'

RSpec.describe "Create Post", type: :system do
  fixtures :users # Load users from fixtures

  let(:user) { users(:one) } # Assume you have a user fixture

  before do
    driven_by(:rack_test)
    visit root_path
    click_link 'Sign In'
    visit new_post_path
  end


  it "displays the post creation form" do
    expect(page).to have_content("Create Post")
    expect(page).to have_field("Post Title")
    expect(page).to have_field("Your Post Text")
    expect(page).to have_button("Create Post")
  end

  it "creates a post when the form is submitted with valid data" do
    fill_in "Post Title", with: "Test Post"
    fill_in "Your Post Text", with: "This is the content of my first test post."

    click_button "Create Post"

    expect(page).to have_content("Post was successfully created") # Adjust based on your flash message
    expect(page).to have_content("Test Post")
  end

  it "shows an error when submitting an empty form" do
    click_button "Create Post"

    expect(page).to have_content("Error creating post")
  end

  it "logs out when clicking the log out button" do
    click_button "Log Out"

    expect(page).to have_content("Logged out successfully!")
  end
end
