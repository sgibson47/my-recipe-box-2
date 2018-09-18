class MakingsController < ApplicationController

  def index
    if params[:user_id]
      @makings = User.find(params[:user_id]).makings
    else
      @makings = Making.all
    end
  end

end