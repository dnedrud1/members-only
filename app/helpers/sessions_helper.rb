module SessionsHelper
  def log_in(user)
    user.save_token
    cookies.permanent[:remember_token] = user.remember_token
    cookies.permanent[:user_id] = user.id
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.exists?(:id => cookies[:user_id]) ? User.find(cookies[:user_id]) : nil
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def log_out
    current_user.forget
    cookies.delete(:remember_token)
    cookies.delete(:user_id)
    @current_user = nil
  end
end
