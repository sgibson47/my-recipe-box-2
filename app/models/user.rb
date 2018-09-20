class User < ApplicationRecord
  has_secure_password
  has_many :recipes
  has_many :makings
  accepts_nested_attributes_for :makings, reject_if: :all_blank, :allow_destroy => true

  validates :name, :email, presence: true
  validates :password, confirmation: true
  validates :email, uniqueness: true

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.name = auth.info.name
  #     user.email = auth.info.email
  #     user.oauth_token = auth.credentials.token
  #     user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #     user.save!
  #   end
  # end 
end
