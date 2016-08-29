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

passengers = []
journeys = []
cars = []
users = []
speaking_habits = ["Talkative", "Chatty", "SILENCE!"]
uni_course = ["History", "Economics", "Engineering"]

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
    speaking_habits: speaking_habits[x],
    year_of_study: rand(1..4),
    uni_course: uni_course[x],
    smoking: Faker::Boolean.boolean,
    })
end

10.times do
  x = 0
  cars << Car.create!({
    user_id: users[x],
    make: Faker::Vehicle.manufacture,
    name: Faker:: ,
    vrn: Faker::Vehicle.vin ,
    colour: Faker:: ,
    })
  x += 1
end

10.times do
  x = 0
  journeys << Journey.create!({
    user_id: users[x],
    car_id: cars[x],
    pick_up_time: Faker::Time.forward(7, :morning) ,
    pick_up_location: Faker::Address.street_address ,
    drop_off_location: Faker::Address.street_address ,
    completed: false,
    })
  x += 1
end

5.times do
  x = 5
  passengers << Passenger.create!({
    user_id: users[x],
    journey_id: journeys[x],
    driver_rating: nil,
    passenger_rating: nil,
    })
  x +=1
end
