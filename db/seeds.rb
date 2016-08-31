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
    speaking_habits: speaking_habits.sample,
    year_of_study: rand(1..4),
    uni_course: uni_course.sample,
    smoking: Faker::Boolean.boolean,
    password: "123456789"
    })
end

10.times do
  cars << Car.create!({
    user: users.sample,
    make: car_make.sample,
    name: Faker::Pokemon.name,
    vrn: vrn.sample,
    colour: Faker::Color.color_name,
    })
end

10.times do
  journeys << Journey.create!({
    user: users.sample,
    car: cars.sample,
    pick_up_time: Faker::Time.forward(7, :morning) ,
    pick_up_location: "18 Victoria Terrace, Leamington Spa, CV31 3AB",
    drop_off_location: "University of Warwick, Coventry",
    completed: false,
    })
end

5.times do
  Passenger.create!({
    user: users.sample,
    journey: journeys.sample,
    driver_rating: nil,
    passenger_rating: nil,
    })
end
