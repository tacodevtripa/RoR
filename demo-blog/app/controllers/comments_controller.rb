class CommentsController < ApplicationController
  def create
    @post = Post.find_by(id: comment_params["post_id"])
    @comment = Comment.new(user: current_user, post: @post, text: comment_params["text"])
    if @comment.save
      @post.increment_comments_counter
      redirect_to show_user_specific_post_path(@post.author, @post), notice: "Comment was successfully created."
    else
      redirect_to show_user_specific_post_path(@post.author, @post), notice: "Error creating comment."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :post_id) # Allow only specific fields
  end
end
