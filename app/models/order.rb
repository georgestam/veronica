class Order < ApplicationRecord
  
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
  
end

