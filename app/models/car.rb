class Car < ApplicationRecord
  belongs_to :user
  has_many :journeys, dependent: :destroy
  has_many :availabilities, dependent: :destroy

  validates :bio, :travel_distance, :price_hour, presence: true


end
