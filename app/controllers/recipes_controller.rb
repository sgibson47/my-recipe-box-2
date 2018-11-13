class RecipesController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :find_recipe_by_params_id, only: [:update, :destroy, :edit, :show]
  before_action :redirect_if_recipe_belongs_to_another_user, only: [:update, :destroy, :edit]

  def index
    if params[:user_id]
      @recipes = User.find(params[:user_id]).recipes
      render "user_index"
    elsif params[:ingredient]
      @recipes = Recipe.by_ingredient(params[:ingredient])
    elsif params[:sort]
      sort_cases
    else
      @recipes = Recipe.all
    end
  end

  def new
    @recipe = Recipe.new
    build_up_to_5_amount_stubs(@recipe)
  end

  def create
    @recipe = Recipe.new(recipes_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      build_up_to_5_amount_stubs(@recipe)
      render "new"
    end
  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @recipe, status: 200}
    end
  end

  def edit
    build_up_to_5_amount_stubs(@recipe)
  end


  def update
    @recipe.update(recipes_params)
    if @recipe.save
      #maybe add success message
      redirect_to "/recipes/#{@recipe.id}"
    else
      build_up_to_5_amount_stubs(@recipe)
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
      :id,
      :ingredient_id,
      :servings_per_recipe,
      :_destroy
    ])
  end

  def build_up_to_5_amount_stubs(recipe)
    count = recipe.amounts.count
    num_to_build = 5 - count
    num_to_build.times do
      recipe.amounts.build
    end
  end

  def sort_cases
    case params[:sort]
    when "best"
      @recipes = Recipe.by_avg_rating_best
    when "worst"
      @recipes = Recipe.by_avg_rating_worst
    when "new"
      @recipes = Recipe.latest
    when "old"
      @recipes = Recipe.oldest
    end
  end

end