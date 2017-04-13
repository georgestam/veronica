FactoryGirl.define do
  
  factory :order do
    
    journey
    state Order::PENDING_PAYMENT
    price_hour { 1 + Random.rand(50) }
    default_minutes = Random.rand(1..120)
    minutes { default_minutes }
    
    after(:build) do |rec, eva|
      rec.calculate_consumer_total_cents!
    end
    
    trait :paid do
      state Order::PAID
      stripe_charge_id { SecureRandom.hex }
    end
    
  end
  
end