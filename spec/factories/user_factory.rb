FactoryGirl.define do
  
  factory :user do
    
    email { "#{SecureRandom.hex(8)}@mailinator.com" } # mail can be actually checked at mailinator.com.
    password { SecureRandom.hex }
    confirmed_at { DateTime.current }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    
    default_location = 'barcelona'
    address [default_location]
      
  end
  
end