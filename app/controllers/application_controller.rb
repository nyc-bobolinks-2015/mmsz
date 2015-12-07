class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  
  before_action :ensure_logged_in, only: [:new, :create, :update, :destroy]

  def current_user
    current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!session[:user_id]
  end
  private
  
  def ensure_logged_in

    redirect_to root_path unless current_user
  end

end
