class Ingredient < ApplicationRecord
  has_many :amounts
  has_many :recipes, :through => :amounts

  validates :name, :serving_size_number, :serving_size_unit, presence: true
  validates :name, uniqueness: true 


  def name_with_serving_info
    "#{self.name} #{self.serving_size_number} #{self.serving_size_unit}"
  end
end
