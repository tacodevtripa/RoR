class Api::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: { message: "You are authenticated!", posts: Post.all }
  end
end
