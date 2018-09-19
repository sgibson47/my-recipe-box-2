class ApplicationController < ActionController::Base
  before_action :current_user
  helper_method :current_user, :logged_in?
  
  def current_user
    @user = (User.find_by(id: session[:user_id]) || User.new)
  end

  def logged_in?
    current_user.id != nil
  end

  def redirect_if_not_logged_in
    return redirect_to('/') unless logged_in?
  end 

  def redirect_if_logged_in
    return redirect_to("/users/#{current_user.id}") if logged_in?
  end 
end
