class Car < ApplicationRecord
  belongs_to :user
  has_many :journeys
  has_attachment :photo

  # validates :bio, :travel_distance, :price_hour, presence: true


end
