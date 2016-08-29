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

journeys = []
cars = []
users = []
speaking_habits = ["Talkative", "Chatty", "SILENCE!"]
uni_course = ["History", "Economics", "Engineering"]
car_make = %w(Ferrari Porsche BMW Mercedes Mazda Ford Toyota Peugot Audi Mini)
vrn = %w(VW52ZAB G4CLS S9EVO V651GTR M30SLK W200CLK VW55MEL CH55BMW TI33AMG JEZ605R)

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
    password: "123456789"
    })
end

10.times do
  x = 0
  car = Car.new({
    make: car_make[x],
    name: Faker::Pokemon.name,
    vrn: vrn[x],
    colour: Faker::Color.color_name,
    })
  car.user = users[x]
  car.save
  cars << car
  x += 1
end

10.times do
  x = 0
  journey = Journey.create!({
    pick_up_time: Faker::Time.forward(7, :morning) ,
    pick_up_location: Faker::Address.street_address ,
    drop_off_location: Faker::Address.street_address ,
    completed: false,
    })
  journey.car = cars[x]
  journey.user = cars[x].user
  journey.save
  journeys << journey
  x += 1
end

5.times do
  x = 5
  passenger = Passenger.create!({
    user_id: users[x],
    journey_id: journeys[x],
    driver_rating: nil,
    passenger_rating: nil,
    })
  passenger.journey = journeys[x]
  passenger.user = users[x]
  passenger.save
  x +=1
end
