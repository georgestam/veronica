FactoryGirl.define do
  
  factory :user do
    
    email { "#{SecureRandom.hex(8)}@mailinator.com" } # mail can be actually checked at mailinator.com.
    password { SecureRandom.hex }
    confirmed_at { DateTime.current }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    
    default_location = 'barcelona'
    address [default_location]
    
    transient do
      linkedin_verif false
      facebook_verif false
    end
    
    after(:build) do |rec, eva|
      rec.linkedin_verif = eva.linkedin_verif if eva.linkedin_verif
      rec.facebook_verif = eva.facebook_verif if eva.facebook_verif
    end
    
  end
  
end