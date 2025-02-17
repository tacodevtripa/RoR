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
    end
  end
end
