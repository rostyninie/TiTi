class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
   before_filter :message_user

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def login_check
    if session[:user_id].present?
      unless (controller_name == "user") and ["first_login_change_password","login","logout","forgot_password"].include? action_name
        user = User.active.find(session[:user_id])
        
        
      end
    end
  end
  
  def message_user
    @current_user = current_user
  end

  def current_user
    User.active.find(session[:user_id]) unless session[:user_id].nil?
  end
  
   protected
  def login_required
    unless session[:user_id]
      session[:back_url] = request.url
      redirect_to '/'
    end
  end
  def is_loggedin
    if session[:user_id]
      redirect_to :controller => 'users', :action => 'dashboard', :id => 0
    end
  end
  
end
