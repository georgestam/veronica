class Api::V1::JourneysController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_journey, only: [ :show, :update]

  def index
    @journeys = policy_scope(Journey)
  end

  def show
  end

  def update
    if @journey.update(journey_params)
      render :show
    else
      render_error
    end
  end

  def driver
    @user = current_user
    authorize @user
    @journeys_as_driver = current_user.journeys
  end

  def passenger
    @user = current_user
    authorize @user
    @journeys_as_passenger = Passenger.where(user: current_user).map{|passenger| passenger.journey}
  end

  def journey_information
    journeys_information = policy_scope(Journey)
    i = 0
    @journeys = []
    authorize journeys_information

    journeys_information.each do |journey|
      start = journey.pick_up_location.address
      destination = journey.drop_off_location.address
      time = journey.pick_up_time
      driver = journey.user.full_name
      passengers = {}

      journey.passengers.each do |p|
        passengers = p.user.full_name
      end

      @journeys[i] = {
        driver: driver,
        start: start,
        destination: destination,
        time: time,
        passengers: passengers
      }
      i += 1
    end
    p @journeys
  end

  private

  def set_journey
    @journey = Journey.find(params[:id])
    authorize @journey  # For Pundit
  end

  def journey_params
    params.require(:journey).permit(
      :seats_available,
      :pick_up_time,
      pick_up_location_attributes: [ :address ],
      drop_off_location_attributes: [ :address ]
    )
  end

  def render_error
    render json: { errors: @journey.errors.full_messages },
      status: :unprocessable_entity
  end
end
