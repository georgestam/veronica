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
Availability.destroy_all


journeys = []
cars = []
users = []
avaliabilities = []
locations = []

price_per_hour = [15, 20, 10, 22]


weekdays = %w(Mondays Tuesdays Wednesday Thursday Friday Saturday Sunday)


pick_up_locations = [
  "107 Tachbrook Road, Leamington Spa CV31 3EA, UK",
  "Leamington Spa Train Station, UK",
  "18 Victoria Terrace, Leamington, UK",
  "2 Kenilworth Road, Leamington Spa CV32, UK",
  "49 Kenilworth Road, Leamington Spa CV32, UK",
  "8A Clarendon Place, Leamington Spa CV32 5QN, UK",
  "45C Lansdowne Crescent, Willes Road, Leamington Spa CV32 4PR, UK"]


urls = [
  "https://www.facebook.com/photo.php?fbid=10153305556957255&set=a.393745102254.165750.540587254&type=3&theater",
  "https://www.facebook.com/photo.php?fbid=10204698295810578&set=a.1467211333558.67125.1631808436&type=3&theater",
  "https://www.facebook.com/photo.php?fbid=10208287125150633&set=a.1510576839233.66983.1078713308&type=3&theater",
  "https://www.facebook.com/photo.php?fbid=10209917022301075&set=a.1647925116886.85576.1199679679&type=3&theater",
  "https://www.facebook.com/photo.php?fbid=10210127811571738&set=a.1626325977984.2085864.1231568856&type=3&theater",
  "https://www.facebook.com/photo.php?fbid=1235898446420687&set=a.157881727555703.33305.100000016307106&type=3&theater",
  "http://www.careerfaqs.com.au/images/news_pages/female_student_4981183.jpg",
  "http://www.canberra.edu.au/__data/assets/image/0013/1060222/student-laughing-in-the-library.jpg",
  "http://www.berkeley.edu/images/photo_uploads/sq-artstudent2.jpg",
  "http://www-tc.pbs.org/wnet/tavissmiley/files/2016/06/Education.jpg",
  "https://www.pokitpal.com/Content/img/www/graduating-students.jpg",
  "https://www.britishcouncil.org/sites/default/files/13_korea_2012_907.jpg",
  "https://www.pitchup.com/static/v8/uploads/Student.png"
  ]

urls_linkedin = [
"https://www.linkedin.com/in/jordi-fernandez-msc-ceng-bb42ab12?trk=nav_responsive_tab_profile",
"https://www.linkedin.com/in/einateyal?trk=pub-pbmap",
"https://www.linkedin.com/in/juanherrada?trk=pub-pbmap",
"https://es.linkedin.com/in/cristina-crucianu-415268b0/en"
]

urls_facebook = [
"https://www.facebook.com/alfredo.glz.glz?pnref=lhc.unseen",
"https://www.facebook.com/laura.ludmany?pnref=lhc.unseen",
"https://https://www.facebook.com/james.bunt?pnref=lhc.friends",
"https://www.facebook.com/alfredo.glz.glz?pnref=lhc.unseen"
]

videos_url = [
"https://www.youtube.com/watch?v=Bdw2wAXe97Y",
"https://www.youtube.com/watch?v=zE_iwkMoGbQ",
"https://www.youtube.com/watch?v=hBCWeJVkb0Q",
"https://www.youtube.com/watch?v=8tMENwHyTOU"
]



10.times do
  x = rand(0..2)

  user = User.new({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    phone_number: Faker::PhoneNumber.phone_number,
    description: Faker::Lorem.paragraph,
    gender: Faker::Boolean.boolean ? "male" : "female",
    password: "123456789",
    linkedin_URL: Faker::Boolean.boolean ? urls_linkedin.sample : "",
    facebook_URL: Faker::Boolean.boolean ? urls_facebook.sample : "",
    # bank_account: Faker::Number.number(7),
    interview_verif: Faker::Boolean.boolean ? true : false,
    date_of_birth: Faker::Date.between(6570.days.ago, 10000.days.ago),
    address: Faker::Boolean.boolean ? pick_up_locations.sample : ""
    })
  user.photo = open(urls.sample)
  user.save
  users << user
end

x = 0

5.times do
  cars << Car.create!({
    user: users.sample,
    video_URL: Faker::Boolean.boolean ? videos_url.sample : "",
    bio: Faker::Lorem.paragraphs,
    price_hour: price_per_hour.sample,
    travel_distance: rand(1..10)
    })
  x += 1
end

end_time = 0

30.times do
  start_time = Faker::Time.forward(7, :evening)
  end_time = start_time + 60*60*3
  avaliabilities << Availability.create!({
    car: cars.sample,
    weekday: weekdays.sample,
    start: start_time,
    finish: end_time
    })
end

10.times do
  journeys << Journey.create!({
    user: users.sample,
    car: cars.sample,
    seats_available: rand(1..4),
    pick_up_time: Faker::Time.forward(7, :morning),
    duration: rand(1..4),
    address: pick_up_locations.sample,
    completed: false,
    })
end

5.times do
  Passenger.create!({
    user: users.sample,
    journey: journeys.sample,
    driver_rating: rand(1..5),
    passenger_rating: rand(1..5),
    driver_review: Faker::Lorem.paragraphs,
    passenger_review: Faker::Lorem.paragraphs
    })
end


# admin user

admin = User.new({
    first_name: "Cristina",
    last_name: "Crucianu",
    email: "cristina@gmail.com",
    phone_number: "0000000051",
    description: "I am myself",
    gender: "female",
    password: "password",
    linkedin_URL: "",
    facebook_URL: "",
    # bank_account: "1234567",
    interview_verif: false,
    date_of_birth: Time.new(2002, 10, 31),
    address: "Plaça de la Paeria, 1, 25007 Lleida, Spain"
    })
  admin.photo = open("http://res.cloudinary.com/georgestam/image/upload/v1476103177/dtwp5e5fj2vqiv0mkacn.jpg")
  admin.save


car_admin = Car.create!({
    user: admin,
    video_URL: "",
    bio: "I am a self-made woman entrepreneur and proficient linguist in English, Spanish, French, Italian, Catalan and Rumanian. I am a team worker, with high compromise, responsibility and positive attitude to achieve short and long-term objectives. I apply constant effort in the areas of productivity and quality of every performed work. I am also an entrepreneur, polifacetic and charismatic English teacher. I am willing to continue progressing in my teaching career and combine it with my other passion: entrepreneurship. Creative, ambitious and energetic, always ready to roll sleeves up and establish plans and solutions in order to achieve strategic business initiatives and deliver results. I have total availability at the moment and may be contacted in the referred email anytime.",
    price_hour: 30,
    travel_distance: 20
    })

end_time = 0

5.times do
  start_time = Faker::Time.forward(7, :evening)
  end_time = start_time + 60*60*3
  avaliabilities << Availability.create!({
    car: car_admin,
    weekday: weekdays.sample,
    start: start_time,
    finish: end_time
    })
end

3.times do
  journeys << Journey.create!({
    user: users.sample,
    car: car_admin,
    seats_available: rand(1..4),
    pick_up_time: Faker::Time.forward(7, :morning),
    duration: rand(1..4),
    address: pick_up_locations.sample,
    completed: false,
    })
end

1.times do
  Passenger.create!({
    user: users.sample,
    journey: journeys.last,
    driver_rating: rand(1..5),
    passenger_rating: rand(1..5),
    driver_review: Faker::Lorem.paragraphs,
    passenger_review: Faker::Lorem.paragraphs
    })
end



