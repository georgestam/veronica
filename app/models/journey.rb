class Journey < ApplicationRecord
  belongs_to :user
  belongs_to :car
  has_many :passengers

  belongs_to :pick_up_location, class_name: "Location"
  belongs_to :drop_off_location, class_name: "Location"
  accepts_nested_attributes_for :pick_up_location
  accepts_nested_attributes_for :drop_off_location

  validates :seats_available, presence: true, numericality: true, inclusion: {in: (1..7)}
  validates :pick_up_time, presence: true
  validates :pick_up_location, presence: true
  validates :drop_off_location, presence: true
  validate :journey_date_cannot_be_in_the_past

  def journey_date_cannot_be_in_the_past
    if pick_up_time < Date.today
      errors.add(:pick_up_time, "Cannot be in the past")
    end
  end

  def calc_seats_available
    self.seats_available - self.passengers.count
  end
end
