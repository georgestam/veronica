class Passenger < ApplicationRecord
  belongs_to :user  # The passenger
  belongs_to :journey

  validates :user_id, uniqueness: { scope: :journey_id }
end
