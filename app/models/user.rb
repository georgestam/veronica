
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]
  has_many :passengers, dependent: :destroy
  has_many :cars, dependent: :destroy
  has_many :journeys, dependent: :destroy
  has_attachment :photo
  has_attachment :id_document

  acts_as_token_authenticatable #  This is for API authentication

  validates :email, uniqueness: true, format: { with: /\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\b/ }
  validates :first_name, presence: true
  validates :last_name, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed_and_development_or_production?
  
  validates :address, presence: true, on: :update

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if results.first
      geo = results.first
      obj.city    = geo.city
      obj.country = geo.country_code
    end
  end
  after_validation :reverse_geocode

  after_create :send_welcome_email
  after_create :subscribe_to_newsletter, if: :development_or_production?
  
  def teacher? 
    self.cars.first
  end 
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def self.find_for_facebook_oauth(auth)

  end

  private

  def send_welcome_email
    UserMailer.welcome(self.id).deliver_now
  end

  def subscribe_to_newsletter
    # SubscribeToNewsletterJob.perform_now(self.id)
    SubscribeToNewsletterService.new(self).call
  end
  
end

