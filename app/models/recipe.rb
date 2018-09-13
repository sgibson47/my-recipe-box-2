class Recipe < ApplicationRecord
  belongs_to :user
  has_many :amounts
  has_many :ingredients, :through => :amounts
  accepts_nested_attributes_for :amounts
end
