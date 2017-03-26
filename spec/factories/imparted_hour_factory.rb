FactoryGirl.define do
  
  factory :imparted_hour do
    
    journey
    default_minutes = Random.rand(1..120)
    minutes { default_minutes }
    date { Date.today }
    
    after(:build) do |rec, eva|
      rec.record_price
    end
  
  end
  
end