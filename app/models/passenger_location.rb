# remove

class PassengerLocation < ApplicationRecord

  locations = [
  "107 Tachbrook Road, Leamington Spa CV31 3EA, UK",
  "Leamington Spa Train Station, UK",
  "18 Victoria Terrace, Leamington, UK",
  "2 Kenilworth Road, Leamington Spa CV32, UK",
  "49 Kenilworth Road, Leamington Spa CV32, UK",
  "8A Clarendon Place, Leamington Spa CV32 5QN, UK",
  "45C Lansdowne Crescent, Willes Road, Leamington Spa CV32 4PR, UK"]

  has_many :passengers

  validates :address, presence: true, inclusion: { in: locations }

  geocoded_by :address
  after_validation :geocode, only: :address_changed?
end
