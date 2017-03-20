FactoryGirl.define do
  
  factory :journey do
    
    user
    car
    seats_available { 1 + rand(6) }
    
  end
  
end