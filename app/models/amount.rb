class Amount < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

  def ingred_for_display
    num = self.servings_per_recipe * ingredient.serving_size_number 

    "#{num} #{self.ingredient.serving_size_unit} #{self.ingredient.name}" 
  end
end
