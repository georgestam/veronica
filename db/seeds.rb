# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Passenger.destroy_all
Journey.destroy_all
Car.destroy_all
User.destroy_all
Location.destroy_all
PassengerLocation.destroy_all

journeys = []
cars = []
users = []
speaking_habits = ["Talkative", "Chatty", "SILENCE!"]
uni_course = ["History", "Economics", "Engineering"]
car_make = %w(Ferrari Porsche BMW Mercedes Mazda Ford Toyota Peugot Audi Mini)
vrn = %w(VA52ZAB G4ALS S9EAO V651GAR M30SAK W200CAK VW55MAL CH55BAW TI33AAG JAZ605R)
pick_up_locations = [
  "107 Tachbrook Road, Leamington Spa CV31 3EA, UK",
  "Leamington Spa Train Station, UK",
  "18 Victoria Terrace, Leamington, UK",
  "2 Kenilworth Road, Leamington Spa CV32, UK",
  "49 Kenilworth Road, Leamington Spa CV32, UK",
  "8A Clarendon Place, Leamington Spa CV32 5QN, UK",
  "45C Lansdowne Crescent, Willes Road, Leamington Spa CV32 4PR, UK"]
passenger_locations = []

20.times do
  x = rand(0..2)

  users << User.create!({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    phone_number: Faker::PhoneNumber.phone_number,
    description: Faker::Lorem.paragraph,
    gender: Faker::Boolean.boolean ? "male" : "female",
    student_id: Faker::Number.number(7),
    date_of_birth: Faker::Date.between(6570.days.ago, 10000.days.ago),
    music_habits: Faker::Music.instrument ,
    speaking_habits: speaking_habits.sample,
    year_of_study: rand(1..4),
    uni_course: uni_course.sample,
    smoking: Faker::Boolean.boolean,
    password: "123456789"
    })
end

x = 0

10.times do
  cars << Car.create!({
    user: users.sample,
    make: car_make.sample,
    name: Faker::Pokemon.name,
    vrn: vrn[x],
    colour: Faker::Color.color_name,
    })
  x += 1
end

#  Passenger pick-up locations
pick_up_locations.each do |location|
  passenger_locations << PassengerLocation.create!({
    address: location
    })
end

# Driver drop-off location
drop_off_location = Location.create!(address: "University of Warwick, Gibbet Hill Road, UK")

# Driver departure location
departure_location = Location.create!(address: "73 Brunswick Street, Leamington, UK")

10.times do
  journeys << Journey.create!({
    user: users.sample,
    car: cars.sample,
    seats_available: rand(3..4),
    pick_up_time: Faker::Time.forward(7, :morning) ,
    pick_up_location: departure_location,
    drop_off_location: drop_off_location,
    completed: false,
    })
end

5.times do
  Passenger.create!({
    user: users.sample,
    journey: journeys.sample,
    passenger_location_id: passenger_locations.sample.id,
    driver_rating: nil,
    passenger_rating: nil,
    })
end
