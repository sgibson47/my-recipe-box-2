class Recipe < ApplicationRecord
  belongs_to :user
  has_many :makings
  has_many :amounts
  has_many :ingredients, :through => :amounts
  accepts_nested_attributes_for :amounts, reject_if: :all_blank, :allow_destroy => true

  validates :name, presence: true
  validates :name, uniqueness: true 
  

  def self.five_most_recent_recipes
    order(:created_at).limit(5)
  end

  def times_made
    self.makings.count
  end

  def self.by_ingredient(ingred_id)
    includes(:ingredients).where(ingredients: {id: "#{ingred_id}"})
  end


end
