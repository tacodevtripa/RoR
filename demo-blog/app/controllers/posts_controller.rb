class PostsController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @posts = Post.all
    respond_to do |format|
      format.html # Renders the HTML view by default
      format.json { render json: @posts }
    end
  end

  def create
    user_params = JSON.parse(request.body.read)
    @post = Post.new(user_params)
    if @user.save
      render json: @post, status: :created, post: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    begin
      user_params = JSON.parse(request.body.read)
      @post = Post.update(params[:id], user_params)
      render json: @post
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Post not found" }, status: :not_found
    end
  end

  def delete
    begin
      Post.find(params[:id]).delete
      render json: { "message": "delete success" }
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Post not found" }, status: :not_found
    end
  end
end
