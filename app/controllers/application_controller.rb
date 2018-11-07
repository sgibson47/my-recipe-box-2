class ApplicationController < ActionController::Base
  before_action :current_user
  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= (User.find_by(id: session[:user_id]) || User.new)
  end

  def logged_in?
    !!current_user
    #current_user.id != nil
  end

  def redirect_if_not_logged_in
    return redirect_to('/') unless logged_in?
  end 

  def redirect_if_logged_in
    return redirect_to("/users/#{current_user.id}") if logged_in?
  end 

  def recipe_belongs_to_current_user?
    return @recipe.user_id == current_user.id
  end

  def redirect_if_recipe_belongs_to_another_user
    unless recipe_belongs_to_current_user?
      flash[:message] = "You can't edit or delete another user's recipes."
      return redirect_to("/users/#{current_user.id}")
    end
  end

  def making_belongs_to_current_user?
    return @making.user_id == current_user.id
  end

  def redirect_if_making_belongs_to_another_user
    unless making_belongs_to_current_user?
      flash[:message] = "You can't edit or delete another user's making."
      return redirect_to("/users/#{current_user.id}") 
    end
  end
end
