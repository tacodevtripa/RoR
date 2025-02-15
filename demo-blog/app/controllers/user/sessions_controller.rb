# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :verify_authenticity_token, only: [ :create ]
  respond_to :json

  # GET /resource/sign_in
  def new
    super
  end

  def create
    respond_to do |format|
      format.html { super } # Render the normal sign-in page for browsers
      format.json {
        user = User.find_by(email: params[:user][:email])

        if user && user.valid_password?(params[:user][:password])
          token = JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.credentials.jwt_secret_key, "HS256")

          render json: { token: token }, status: :ok
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      }
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  #
  # private

  # def respond_with(resource, _opts = {})
  #   render json: { message: "Logged in successfully.", user: resource }, status: :ok
  # end

  # def respond_to_on_destroy
  #   head :no_content
  # end
end
