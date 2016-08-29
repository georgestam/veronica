class Passenger < ApplicationRecord
  belongs_to :user
  belongs_to :journey
end
