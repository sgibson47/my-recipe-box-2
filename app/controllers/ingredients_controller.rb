class IngredientsController < ApplicationController
  before_action :require_logged_in

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
    @ingredient = Ingredient.find(params[:id])
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end


  def update
    @ingredient = Ingredient.find(params[:id])
    @ingredient.update(ingredients_params)
    if @ingredient.save
      #maybe add success message
      redirect_to "/ingredients/#{@ingredient.id}"
    else
      render "edit"
    end
  end

  def destroy
  end

  private

  def ingredients_params
    params.require(:ingredient).permit(:name, :serving_size_number, :serving_size_unit)
  end
end