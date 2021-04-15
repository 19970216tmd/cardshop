class ApplicationController < ActionController::Base
    helper_method :current_user, :user_signed_in?

  def login?
    if current_user.nil?
      redirect_to login_path, alert: "You have to log in."
    end
  end

  def already_login?
    unless current_user.nil?
      redirect_to root_path, notice: "You are already logged in."
    end
  end


  def current_user
    if session[:user_id]
      current_user ||= User.find(session[:user_id])
    end
  end
  
  def user_signed_in?
    !!current_user
  end
end
