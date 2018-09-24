class User < ApplicationRecord
  has_secure_password
  has_many :recipes
  has_many :makings
  accepts_nested_attributes_for :makings, reject_if: :all_blank, :allow_destroy => true

  validates :name, :email, presence: true
  validates :password, confirmation: true
  validates :email, uniqueness: true

  def five_most_recent_user_recipes
    recipes.order(:created_at).limit(5)
  end 

  def five_most_recent_user_makings
    makings.order(:created_at).limit(5)
  end 

  def own_recipes_with_ingredient(id)
    
  end

end

