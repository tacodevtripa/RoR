require 'rails_helper'

RSpec.describe UserController, type: :controller do
  fixtures :users, :posts

  describe "GET #index" do
    it "returns a successful response and all users" do
      get :index, format: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body).size).to eq(User.count)
    end
  end

  describe "GET #show_user" do
    context "when the user exists" do
      it "returns the user" do
        user = users(:one)
        get :show_user, params: { id: user.id }, format: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)["name"]).to eq(user.name)
    end
  end

    context "when the user does not exist" do
      it "returns a not found error" do
        get :show_user, params: { id: -1 }, format: :json
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["error"]).to eq("User not found")
      end
    end
  end

  describe "GET #show_user_posts" do
  context "when the user exists" do
    it "returns the user" do
      user = users(:one)
      get :show_user_posts, params: { id: user.id }, format: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["name"]).to eq(user.name)
  end
end

  context "when the user does not exist" do
    it "returns a not found error" do
      get :show_user_posts, params: { id: -1 }, format: :json
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("User not found")
    end
  end
  end

  describe "GET #show_user_specific_post" do
  context "when the user exists" do
    it "returns the user" do
      user = users(:one)
      post = posts(:one)
      get :show_user_specific_post, params: { id: user.id, post_id: post.id }, format: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body)["author_id"]).to eq(user.id)
  end
  end

  context "when the user does not exist" do
    it "returns a not found error" do
      get :show_user_specific_post, params: { id: -1, post_id: -1 }, format: :json
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("User not found")
    end
  end
  end

  describe "POST #create" do
    it "creates a new user and returns it" do
      post :create, body: { name: "New User", posts_counter: 0 }.to_json
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["name"]).to eq("New User")
    end

    it "returns errors if user creation fails" do
      post :create, body: { name: "" }.to_json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to include("name")
    end
  end

  describe "PUT #update" do
    context "when the user exists" do
      it "updates the user and returns it" do
        user = users(:one)
        put :update, params: { id: user.id }, body: { name: "Updated Name" }.to_json
        expect(response).to be_successful
        expect(JSON.parse(response.body)["name"]).to eq("Updated Name")
      end
    end

    context "when the user does not exist" do
      it "returns a not found error" do
        put :update, params: { id: -1 }, body: { name: "Updated Name" }.to_json
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["error"]).to eq("User not found")
      end
    end
  end

  describe "DELETE #delete" do
    context "when the user exists" do
      it "deletes the user and returns a success message" do
        user = users(:one)
        delete :delete, params: { id: user.id }
        expect(response).to be_successful
        expect(JSON.parse(response.body)["message"]).to eq("delete success")
        expect(User.exists?(user.id)).to be_falsey
      end
    end

    context "when the user does not exist" do
      it "returns a not found error" do
        delete :delete, params: { id: -1 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["error"]).to eq("User not found")
      end
    end
  end
end
