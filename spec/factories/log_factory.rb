FactoryGirl.define do
  
  factory :log do
    
    journey
    default_minutes = Random.rand(1..120)
    minutes { default_minutes }
    date { Date.today }
    
    trait :paid do
      minutes_paid [default_minutes]
      date_paid { Date.today }
    end
    
  end
  
end