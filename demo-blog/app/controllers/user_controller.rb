class UserController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @users = User.all
  end

  def show_user
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def show_user_posts
    begin
      @user = User.find(params[:id])
      @posts = @user.posts.order(:created_at).page(params[:page]).per(3)
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def show_user_specific_post
    begin
      @user = User.find(params[:id])
      @post = Post.find(params[:post_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def create
    user_params = JSON.parse(request.body.read)
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, user: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    begin
      user_params = JSON.parse(request.body.read)
      @user = User.update(params[:id], user_params)
      render json: @user
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def delete
    begin
      User.find(params[:id]).delete
      render json: { "message": "delete success" }
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found
    end
  end
end
