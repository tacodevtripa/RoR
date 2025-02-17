module Api
  module V1
    class UserController < Api::V1::BaseController
      def show_posts
        begin
          @user = User.find(params[:id])
          render json: @user.posts
        rescue ActiveRecord::RecordNotFound
          render json: { error: "There was an error with the input data" }, status: :not_found
        end
      end
    end
  end
end
