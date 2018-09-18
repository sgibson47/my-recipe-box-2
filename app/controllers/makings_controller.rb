class MakingsController < ApplicationController

  def index
    if params[:user_id]
      @makings = User.find(params[:user_id]).makings
    elsif params[:recipe_id]
      @makings = Recipe.find(params[:recipe_id]).makings
    end
  end

  def show
    @making = Making.find(params[:id])
  end

  def new
    @user = current_user
    @making = @user.makings.build
  end

  def create
    @making = Making.new(makings_params)
    @making.user = User.find(params[:user_id])
    if @making.save
      redirect_to "/makings/#{@making.id}"
    else
      render "new"
    end
  end

  private 

  def makings_params
    params.require(:making).permit(:recipe_id, :rating, :notes)
  end

end