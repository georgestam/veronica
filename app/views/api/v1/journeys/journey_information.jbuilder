json.array! @journeys do |journey|
  json.extract! journey, :driver, :start, :destination, :time, :passengers
end
