FactoryGirl.define do
  
  factory :car do
    
    user
    bio { Faker::Lorem.paragraph }
    travel_distance { 1 + Random.rand(9) }
    price_hour { 1 + Random.rand(50) }
    
  end
  
end