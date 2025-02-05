require 'rails_helper'

RSpec.describe 'Posts Index Page', type: :system do
  fixtures :users, :posts

  before do
    driven_by(:rack_test)
    visit post_index_path
  end

  it 'displays all posts with titles' do
    posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'displays all posts with body' do
    posts.each do |post|
      expect(page).to have_content(post.text)
    end
  end

  it 'displays all posts with count of comments and likes' do
    posts.each do |post|
      expect(page).to have_content(post.likes_counter)
      expect(page).to have_content(post.comments_counter)
    end
  end

  it 'displays all posts with link to specific post view' do
    posts.each do |post|
      expect(page).to have_link('see post', href: show_user_specific_post_path(users(:one).id, post.id))
    end
  end
end
