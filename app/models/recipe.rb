class Recipe < ApplicationRecord
  belongs_to :user
  has_many :amounts
  has_many :ingredients, :through => :amounts
end
