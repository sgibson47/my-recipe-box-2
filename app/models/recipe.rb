class Recipe < ApplicationRecord
  belongs_to :user
  has_many :amounts
  has_many :ingredients, :through => :amounts
  accepts_nested_attributes_for :amounts, reject_if: :all_blank

  validates :name, presence: true
  validates :name, uniqueness: true 

  def amounts_attributes=(attr_hash)
    #need to avoid duplicative amounts in a recipe, so build custom setter
  end
end
