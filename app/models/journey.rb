class Journey < ApplicationRecord
  belongs_to :user
  belongs_to :car
  has_many :passengers

  # validates :start_time, :finish_time, :num_of_students, presence: true

  validates :seats_available, presence: true, numericality: true, inclusion: {in: (1..7)}
  validates :pick_up_time, presence: true
  validate :journey_date_cannot_be_in_the_past

  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode, only: :address_changed?

  def journey_date_cannot_be_in_the_past
    if pick_up_time < Date.today
      errors.add(:pick_up_time, "Cannot be in the past")
    end
  end

  def remaining_seats
    seats_available - passengers.size
  end

  def full?
    remaining_seats == -1
  end
end
