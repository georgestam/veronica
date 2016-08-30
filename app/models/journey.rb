class Journey < ApplicationRecord
  belongs_to :user
  belongs_to :car
  has_many :passengers
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


end
