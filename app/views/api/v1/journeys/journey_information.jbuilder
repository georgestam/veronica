json.array! @journeys do |journey|
  json.extract! journey, :driver, :start, :destination, :passengers
end
