require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  fixtures :users, :posts # Load fixtures for users and posts
  let(:user) { users(:one) } # Define a test user
  let(:post_instance) { posts(:one) } # Define a test post

  before do
    sign_in users(:one)
  end

  describe "GET #index" do
    it "returns a successful response for HTML" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:posts)).to eq(Post.all)
    end

    it "returns JSON response with all posts" do
      get :index, format: :json
      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(parsed_response.length).to eq(Post.count)
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to have_http_status(:success)
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "POST #create" do
    let(:valid_params) { { post: { author: user, title: "My Title", text: "Post content" } } }
    let(:invalid_params) { { post: { title: "", text: "" } } }

    it "creates a post and increases count" do
      expect {
        post :create, params: valid_params
      }.to change(Post, :count).by(1)
    end

    it "fails to create a post and redirects back with an error" do
      expect {
        post :create, params: invalid_params
      }.not_to change(Post, :count)

      expect(response).to redirect_to(new_post_path)
      expect(flash[:notice]).to eq("Error creating post")
    end
  end

  describe "PATCH #update" do
    let(:update_params) { { title: "Updated Title", text: "Updated content" }.to_json }

    it "updates an existing post and returns JSON" do
      request.headers["CONTENT_TYPE"] = "application/json"
      patch :update, params: { id: post_instance.id }, body: update_params

      post_instance.reload
      expect(response).to have_http_status(:success)
      expect(post_instance.title).to eq("Updated Title")
    end

    it "returns a 404 error for a non-existent post" do
      expect {
        patch :update, params: { id: 99999 }, body: update_params
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "DELETE #delete" do
    it "deletes an existing post and returns success message" do
      expect {
        delete :delete, params: { id: post_instance.id }
      }.to change(Post, :count).by(-1)

      expect(response).to have_http_status(:redirect)
    end

    it "returns a 404 error when trying to delete a non-existent post" do
      expect {
        delete :delete, params: { id: -1 }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
