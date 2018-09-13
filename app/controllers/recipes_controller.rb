class RecipesController < ApplicationController
  before_action :require_logged_in
  before_action :find_recipe_by_params_id, only: [:update, :destroy, :edit, :show]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @recipe.amounts.build
    @recipe.amounts.build
    @recipe.amounts.build
    @recipe.amounts.build
    @recipe.amounts.build
  end

  def create
    @recipe = Recipe.new(recipes_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end


  def update
    @recipe.update(recipes_params)
    if @recipe.save
      #maybe add success message
      redirect_to "/recipes/#{@recipe.id}"
    else
      render "edit"
    end
  end

  def destroy
    @recipe.destroy
    redirect_to "/"
  end

  private

  def find_recipe_by_params_id
    @recipe = Recipe.find(params[:id])
  end

  def recipes_params
    params.require(:recipe).permit(:name, :instructions, amounts_attributes: [
      :ingredient_id,
      :servings_per_recipe
    ])
  end
end