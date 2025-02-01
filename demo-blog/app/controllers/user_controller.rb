class UserController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @users = User.all
    respond_to do |format|
      format.html # Renders the HTML view by default
      format.json { render json: @users }
    end
  end

  def show_user
    begin
      @user = User.find(params[:id])
      respond_to do |format|
        format.html # Renders the HTML view by default
        format.json { render json: @user }
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def show_user_posts
    begin
      @user = User.find(params[:id])
      @posts = @user.posts.order(:created_at).page(params[:page]).per(3)
      respond_to do |format|
        format.html # Renders the HTML view by default
        format.json { render json: @user }
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def show_user_specific_post
    begin
      @user = User.find(params[:id])
      @post = Post.find(params[:post_id])
      respond_to do |format|
        format.html # Renders the HTML view by default
        format.json { render json: @post }
      end
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
