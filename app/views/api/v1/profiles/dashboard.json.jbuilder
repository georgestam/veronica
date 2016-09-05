json.extract! @user, :id,
  :first_name,
  :last_name,
  :email,
  :phone_number,
  :description,
  :gender,
  :student_id,
  :date_of_birth,
  :music_habits,
  :speaking_habits,
  :year_of_study,
  :uni_course,
  :smoking

json.extract! @journeys_as_passenger, :id, :seats_available, :pick_up_time, :pick_up_location, :drop_off_location

json.extract! @journeys_as_driver, :id, :seats_available, :pick_up_time, :pick_up_location, :drop_off_location
