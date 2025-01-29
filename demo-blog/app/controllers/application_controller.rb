class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_current_user
  helper_method :current_user

  private

  def set_current_user
    @current_user = User.find_by(id: session[:user_id]) # Retrieves user from session
  end
end
