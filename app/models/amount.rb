class Amount < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

  validates :servings_per_recipe, presence: true

  def ingred_for_display
    if ingredient
      num = self.servings_per_recipe * ingredient.serving_size_number 

      "#{num} #{self.ingredient.serving_size_unit} #{self.ingredient.name}"
    end 
  end
end
