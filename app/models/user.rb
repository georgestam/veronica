class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :passengers
  has_many :cars
  has_many :journeys
  has_attachment :photo

  validates :email, uniqueness: true, format: { with: /\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b/ }
  validates :first_name, presence: true
  validates :last_name, presence: true

  after_create :send_welcome_email

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end

