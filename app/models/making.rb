class Making < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  def self.five_most_recent_makings
    order(:created_at).limit(5)
  end

  
end
