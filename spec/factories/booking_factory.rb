FactoryGirl.define do
  
  pick_up_locations = [
    "107 Tachbrook Road, Leamington Spa CV31 3EA, UK",
    "Leamington Spa Train Station, UK",
    "18 Victoria Terrace, Leamington, UK",
    "2 Kenilworth Road, Leamington Spa CV32, UK",
    "49 Kenilworth Road, Leamington Spa CV32, UK",
    "8A Clarendon Place, Leamington Spa CV32 5QN, UK",
    "45C Lansdowne Crescent, Willes Road, Leamington Spa CV32 4PR, UK"]
  
  factory :journey do
    
    user
    car
    seats_available { Random.rand(1..4) }
    duration { Random.rand(1..6) }
    pick_up_time { Faker::Time.forward(7, :morning) }
    address { pick_up_locations.sample }
    completed { false }
    
  end
  
  trait :completed do
    completed { true }
  end
  
end