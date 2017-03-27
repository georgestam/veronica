class ImpartedHour < ApplicationRecord
  belongs_to :journey
  
  validates :minutes, presence: true
  validates :date, presence: true
  validates :price_cents, presence: true
  
  def record_price
    self.price_cents = ((self.journey.car.price_hour.to_f)*(self.minutes.to_f/60)*100).to_i
  end 
  
end
