class Car < ApplicationRecord
  belongs_to :user
  has_many :journeys
  has_many :availabilities
  has_attachment :photo

  validates :bio, :travel_distance, :price_hour, presence: true


end
