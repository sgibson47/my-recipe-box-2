class User < ApplicationRecord
  has_secure_password

  validates :name, :email, presence: true
  validates :password, confirmation: true
  validates :email, uniqueness: true 

  has_many :recipes
end
