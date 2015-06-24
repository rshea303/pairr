class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def authorize!
    flash[:alert] = "Unauthorized Access!  Please sign in to continue."
    redirect_to root_path unless current_user
  end

end
