class RecipeIngredientSerializer < ActiveModel::Serializer
  attributes :id, :name, :instructions, :user_id
end
