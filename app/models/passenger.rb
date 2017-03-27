class Passenger < ApplicationRecord

  RATINGS = [1, 2, 3, 4, 5]

  belongs_to :user  # The passenger
  belongs_to :journey

  # remove
  belongs_to :passenger_location

  validates :journey_id, uniqueness: { scope: :journey_id }
  validates :driver_rating,  inclusion: { in: RATINGS, allow_nil: false }

end
