class CommentsController < ApplicationController
  load_and_authorize_resource # Ensures CanCanCan enforces permissions

  def create
    @post = Post.find_by(id: comment_params[:post_id])
    @comment = @post.comments.build(user: current_user, text: comment_params[:text])

    if @comment.save
      @post.increment_comments_counter
      redirect_to show_user_specific_post_path(@post.author, @post), notice: "Comment was successfully created."
    else
      redirect_to show_user_specific_post_path(@post.author, @post), alert: "Error creating comment."
    end
  end

  def delete
    @comment = Comment.find(params[:id])
    authorize! :delete, @comment # Explicit authorization check

    if @comment.delete
      @comment.post.decrement!(:comments_counter)
      redirect_to show_user_specific_post_path(@comment.post.author, @comment.post), notice: "Comment deleted."
    else
      redirect_to show_user_specific_post_path(@comment.post.author, @comment.post), alert: "Could not delete comment."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :post_id) # Allow only specific fields
  end
end
