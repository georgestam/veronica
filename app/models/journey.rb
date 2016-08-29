class Journey < ApplicationRecord
  belongs_to :user
  belongs_to :car
  has_many :passengers
end
