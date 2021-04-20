class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?

  def login?
    redirect_to login_path, alert: 'You have to log in.' if current_user.nil?
  end

  def already_login?
    redirect_to root_path, notice: 'You are already logged in.' unless current_user.nil?
  end

  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end
end
