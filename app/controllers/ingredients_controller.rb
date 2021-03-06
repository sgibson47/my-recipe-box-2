class IngredientsController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :find_ingredient_by_params_id, only: [:update, :destroy, :edit, :show]

  def index
    @ingredients = Ingredient.all
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @ingredients, status: 200}
    end
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredients_params)
    if @ingredient.save
      redirect_to ingredient_path(@ingredient)
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end


  def update
    @ingredient.update(ingredients_params)
    if @ingredient.save
      #maybe add success message
      redirect_to "/ingredients/#{@ingredient.id}"
    else
      render "edit"
    end
  end

  def destroy
    @ingredient.destroy
    redirect_to "/ingredients"
  end

  private

  def find_ingredient_by_params_id
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredients_params
    params.require(:ingredient).permit(:name, :serving_size_number, :serving_size_unit)
  end
end