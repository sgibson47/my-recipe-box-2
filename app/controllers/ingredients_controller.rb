class IngredientsController < ApplicationController
  before_action :require_logged_in

  def new
    @ingredient = Ingredient.new
  end

end