module Api
  module V1
    class BaseController < ActionController::API
      before_action :authenticate_user_from_token!

      private

      def authenticate_user_from_token!
        token = request.headers['Authorization']&.split&.last
        if token
          decoded_token = JWT.decode(token, Rails.application.credentials.jwt_secret_key!, true, { algorithm: 'HS256' })
          user_id = decoded_token[0]['user_id']
          @current_user = User.find(user_id) # Set current_user manually
        else
          render json: { error: 'Token missing or invalid' }, status: :unauthorized
        end
      end
    end
  end
end
