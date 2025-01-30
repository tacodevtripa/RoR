class LikesController < ApplicationController
  def create
    @post = Post.find_by(id: like_params["post_id"])
    @like = Like.new(user: @current_user, post: @post)
    if @like.save
      redirect_to show_user_specific_post_path(@post.author, @post), notice: "You liked this post"
    else
      redirect_to show_user_specific_post_path(@post.author, @post), notice: "There was an error, try again later"
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id) # Allow only specific fields
  end
end
