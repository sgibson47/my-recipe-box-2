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

  def avg_rating
    makings.average("rating")
  end

  

end
