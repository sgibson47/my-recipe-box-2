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

  def top_ingredients
    ingredients 

    #grrrr ingredients & users aren't connected!!
    # I could iterate over each recipe, and 
    # store its ingredients in a new collection and 
    # count number of times each ingredient
    # ewwww
    #Help me, ActiveRecord. You're my only hope. 
  end
end
