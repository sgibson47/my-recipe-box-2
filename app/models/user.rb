class User < ApplicationRecord
  has_secure_password
  has_many :recipes

  validates :name, :email, presence: true
  validates :password, confirmation: true
  validates :email, uniqueness: true 
end
