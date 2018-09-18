class MakingsController < ApplicationController
  before_action :find_making_by_params_id, only: [:update, :destroy, :edit, :show]

  def index
    if params[:user_id]
      @makings = User.find(params[:user_id]).makings
    elsif params[:recipe_id]
      @makings = Recipe.find(params[:recipe_id]).makings
    end
  end

  def show
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

  def edit
  
  end

  def update
    
  end

  def destroy
    
  end

  private 

  def makings_params
    params.require(:making).permit(:recipe_id, :rating, :notes)
  end

  def find_making_by_params_id
    @making = Making.find(params[:id])
  end

end