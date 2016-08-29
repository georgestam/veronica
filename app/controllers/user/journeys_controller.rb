class User::JourneysController < Applicationcontroller

  # this is controller to  list all journeys a user has both a passenger and driver )

  def index
    @journeys_as_passenger = Journey.where(user: current_user)
    @journeys_as_driver = Journey.where(car: current_user.cars)
  end
end
