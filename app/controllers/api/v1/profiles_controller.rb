class Api::V1::ProfilesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :dashboard ]

  def dashboard
    @user = current_user
    authorize @user

    @journeys_as_passenger = Passenger.where(user: current_user).map{|passenger| passenger.journey}
    @journeys_as_driver = Journey.where(user: current_user)
  end
end
