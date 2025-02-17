module Api
  module V1
    class PostsController < Api::V1::BaseController
      load_and_authorize_resource

      def show_comments
        begin
          @comments = Post.find(params[:id]).comments
          render json: @comments
        rescue ActiveRecord::RecordNotFound
          render json: { error: "Post not found" }, status: :not_found
        end
      end

      def create_comment_from_api
        # Find the post by its ID
        @post = Post.find(params[:id])
        request_body = JSON.parse(request.body.read)
        # Create a new comment and associate it with the current user
        # puts comment_params
        @comment = @post.comments.new(request_body)
        @comment.user = current_user  # Set the current user as the comment's creator
        if @comment.save
          @post.increment_comments_counter
          render json: @comment, status: :created
        else
          render json: { error: @comment.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
