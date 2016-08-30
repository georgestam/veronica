class User::JourneysController < ApplicationController

  # this is controller to  list all journeys a user has both a passenger and driver )

  def index
    @journeys_as_passenger = Passenger.where(user: current_user).map{|passenger| passenger.journey}
    @journeys_as_driver = Journey.where(user: current_user)
  end
end
