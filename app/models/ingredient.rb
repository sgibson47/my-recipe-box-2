class Ingredient < ApplicationRecord
  has_many :amounts
  has_many :recipes, :through => :amounts
end
