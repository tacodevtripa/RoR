class PostsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource # Ensures CanCanCan enforces permissions

  def index
    @posts = Post.all
    respond_to do |format|
      format.html # Renders the HTML view by default
      format.json { render json: @posts }
    end
  end

  def new
    @post = Post.new
  end

  def update
    post_params = JSON.parse(request.body.read)
    @post = Post.update(params[:id], post_params)
    render json: @post
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: 'Error updating post.'
  end

  def delete
    @post = Post.find(params[:id]).delete
    redirect_to root_path, notice: 'Post was successfully deleted.'
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: 'Error deleting post.'
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user # Assigning current user
    if @post.save
      current_user.increment_posts_counter
      redirect_to show_user_specific_post_path(current_user.id, @post.id), notice: 'Post was successfully created.'
    else
      redirect_to new_post_path, notice: 'Error creating post'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text) # Allow only specific fields
  end
end
