class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :name, :serving_size_number, :serving_size_unit
end
