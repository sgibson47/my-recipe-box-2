class MakingsController < ApplicationController

  def index
    if params[:user_id]
      @makings = User.find(params[:user_id]).makings
    elsif params[:recipe_id]
      @makings = Recipe.find(params[:recipe_id]).makings
    end
  end

end