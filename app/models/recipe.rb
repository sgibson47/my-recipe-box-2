class Recipe < ApplicationRecord
  belongs_to :user
  has_many :makings, dependent: :destroy
  has_many :amounts, dependent: :destroy
  has_many :ingredients, :through => :amounts
  accepts_nested_attributes_for :amounts, reject_if: :all_blank, :allow_destroy => true

  validates :name, presence: true
  validates :name, uniqueness: true 

  scope :by_ingredient, -> (ingred_id) {includes(:ingredients).where(ingredients: {id: "#{ingred_id}"})}
  scope :by_avg_rating_worst, -> { joins(:makings).group("recipes.id").order("avg(makings.rating)") }
  scope :by_avg_rating_best, -> { joins(:makings).group("recipes.id").order("avg(makings.rating) desc") }
  scope :latest, -> { order(created_at: :desc) }
  scope :oldest, -> { order(:created_at) }
  scope :five, -> { limit(5) }
end
  

  def times_made
    makings.count
  end

  def avg_rating
    makings.average("rating").to_s
  

end
