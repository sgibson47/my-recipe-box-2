class User < ApplicationRecord
  has_secure_password
  has_many :recipes
  has_many :makings
  accepts_nested_attributes_for :makings, reject_if: :all_blank, :allow_destroy => true

  validates :name, :email, presence: true
  validates :password, confirmation: true
  validates :email, uniqueness: true


  def users_latest_recipes
    recipes.order(created_at: :desc)
  end 

  def five
    limit(5)
  end

  def users_latest_makings
    makings.order(created_at: :desc)
  end 

end

