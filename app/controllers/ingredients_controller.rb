class IngredientsController < ApplicationController
  before_action :require_logged_in

  def new
    @ingredient = Ingredient.new
  end

  def create
    raise params.inspect
  end

  private

  def ingredients_params
    params.require(:ingredient).permit(:name, :serving_size_number, :serving_size_unit)
  end
end