class Car < ApplicationRecord
  belongs_to :user
  has_many :journeys
  has_attachment :photo

  # validates :bio, :travel_distance, :price_hour, presence: true

  # delete
  validates :make, :name, :colour, presence: true
  validates :vrn, presence: true, uniqueness: true, format: { with: /([A-Z]{2}[0-9]{2}[A-Z]{3}$)|([A-Z][0-9]{1,3}[A-Z]{3}$)|([A-Z]{3}[0-9]{1,3}[A-Z]$)|([0-9]{1,4}[A-Z]{1,2}$)|([0-9]{1,3}[A-Z]{1,3}$)|([A-Z]{1,2}[0-9]{1,4}$)|([A-Z]{1,3}[0-9]{1,3}$)/ }
end
