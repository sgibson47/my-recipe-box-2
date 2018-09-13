class Recipe < ApplicationRecord
  belongs_to :user
  has_many :amounts
  has_many :ingredients, :through => :amounts
  accepts_nested_attributes_for :amounts, reject_if: :all_blank

  validates :name, presence: true
  validates :name, uniqueness: true 
end
