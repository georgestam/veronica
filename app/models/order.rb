class Order < ApplicationRecord
  
  PENDING_PAYMENT = 'pending_payment'.freeze
  PAID = 'paid'.freeze
  
  include ApplicationRecordImpl
  include Approvable
  include Payable
  
  belongs_to :journey
  
  monetize :consumer_total_cents
  
  validates :state, presence: true
  validates :price_hour, presence: true
  validates :minutes, presence: true
  
  after_commit :send_creation_emails, on: :create
  
  def send_creation_emails
    Orders::Creation::Job.perform_now(*job_args)
  end

  def job_args
    [self.class.to_s, self.id]
  end

  def payment_link
    Rails.application.routes.url_helpers.checkout_journey_order_url(show_args)
  end
  
  def show_args
    {journey_id: self.journey.id, id: self.id}
  end
  
  def payable_amount_cents
    consumer_total_cents
  end
  
  def charge_description
    "Order id #{self.id} - Teacher #{self.journey.car.user.first_name}"
  end
  
  def calculate_consumer_total_cents
    self.consumer_total = self.minutes * self.price_hour / 60
  end 
  
  def self.calculate_not_paid_minutes(journey)
    minutes_paid = Order.calculate_minutes_paid(journey)
    imparted_hours = ImpartedHour.where(journey_id: journey)
    minutes = { total_minutes: 0, minutes_paid: minutes_paid, minutes_not_paid: 0 }
  
    imparted_hours.each do |imparted_hour| 
      minutes[:total_minutes] += imparted_hour.minutes
    end 
  
    minutes[:minutes_not_paid] = minutes[:total_minutes] - minutes[:minutes_paid] 
    
    minutes
    
  end
  
  def self.calculate_minutes_paid(journey)
    
    orders = Order.where(journey_id: journey).where(state: Order::PAID)
    minutes_paid = 0
    orders.each do |order| 
      amount = (order.consumer_total_cents / 100).to_i
      minutes_paid += amount * 60 / (order.price_hour)
    end 
    
    minutes_paid
    
  end
  
end

