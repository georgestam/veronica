class Car < ApplicationRecord
  belongs_to :user
  has_many :journeys, dependent: :destroy
  has_many :availabilities, dependent: :destroy

  validates :bio, presence: true
  validates :video_URL, presence: true
  validates :travel_distance, presence: true
  validates :price_hour, presence: true

end
