class Journey < ApplicationRecord
  belongs_to :user
  belongs_to :car
  validates :seats_available, presence: true, numericality: true, inclusion: {in: (1..7)}
  validates :pick_up_time, presence: true
  validates :pick_up_location, presence: true
  validates :drop_off_location, presence: true
end
