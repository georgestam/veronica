class Location < ApplicationRecord
  has_many :journeys

  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, only: :address_changed?

end
