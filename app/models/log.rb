class Log < ApplicationRecord
  belongs_to :journey
  
  validates :minutes, presence: true
  validates :date, presence: true
  
end
