class SessionsController < ApplicationController
  def sign_in
    session[:user_id] = User.first.id # Logs in the first user (replace this with real authentication)
    redirect_to root_path, notice: "Signed in successfully!"
  end

  def log_out
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully!"
  end
end
