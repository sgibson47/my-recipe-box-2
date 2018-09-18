class User < ApplicationRecord
  has_secure_password
  has_many :recipes
  has_many :makings

  validates :name, :email, presence: true
  validates :password, confirmation: true
  validates :email, uniqueness: true 
end
