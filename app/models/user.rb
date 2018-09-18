class User < ApplicationRecord
  has_secure_password
  has_many :recipes
  accepts_nested_attributes_for :recipes, reject_if: :all_blank, :allow_destroy => true

  validates :name, :email, presence: true
  validates :password, confirmation: true
  validates :email, uniqueness: true 
end
