class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :instructions, :user_id

  has_many :amounts
  has_many :ingredients
end
