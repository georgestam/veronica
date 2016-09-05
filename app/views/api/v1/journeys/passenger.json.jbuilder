json.array! @journeys_as_passenger do |journey|
  json.extract! journey, :id, :seats_available, :pick_up_time, :pick_up_location, :drop_off_location
end
