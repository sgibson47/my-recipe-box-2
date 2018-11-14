class MakingsController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :find_making_by_params_id, only: [:update, :destroy, :edit, :show]
  before_action :redirect_if_making_belongs_to_another_user, only: [:update, :destroy, :edit]
  skip_before_action :verify_authenticity_token, only: [:createFromRecipe]

  def index
    if params[:user_id]
      @makings = User.find(params[:user_id]).makings
    else
      @makings = Making.all
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

  def createFromRecipe
    @making = Making.new(makings_params)
    @making.user = current_user
    if @making.save
      render json: @making, status: 200
    end
  end

  def edit
  end

  def update
    @making.update(makings_params)
    if @making.save
      redirect_to "/makings/#{@making.id}"
    else
      render "edit"
    end
  end

  def destroy
    @making.destroy
    redirect_to "/users/#{current_user.id}"
  end

  private 

  def makings_params
    params.require(:making).permit(:recipe_id, :rating, :notes)
  end

  def find_making_by_params_id
    @making = Making.find(params[:id])
  end

end