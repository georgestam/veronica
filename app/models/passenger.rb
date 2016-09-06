class Passenger < ApplicationRecord
  belongs_to :user
  belongs_to :journey
  belongs_to :passenger_locations
end
