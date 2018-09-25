class Making < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  scope :latest, -> { order(created_at: :desc) }
  scope :five, -> { limit(5) }

end
