class Location < ApplicationRecord
  has_one :journey

  geocoded_by :address
  after_validation :geocode, only: :address_changed?
end
