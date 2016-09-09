class JourneysController < ApplicationController
  before_action :set_journey, only:[:show, :edit, :update, :destroy, :driver_journey]
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  def index
    @journeys = policy_scope(Journey)
    @available_journeys = @journeys.select{ |journey| journey.remaining_seats > 0 && journey.completed != true}
    @available_journeys.sort { |x,y| x.pick_up_time <=> y.pick_up_time }
  end

  def show
    @journey = Journey.find(params[:id])
    set_passenger_locations # This sets which locations the passenger can pick from based on all PassengerLocations and the drivers departure location
    @car = @journey.car
    create_waypoints # This will create an array of waypoints to give to the map
  end

  def new
    @car = Car.find(params[:car_id])
    @journey = Journey.new
    @journey.car = @car
    @journey.build_pick_up_location
    @journey.build_drop_off_location
    authorize @journey
  end

  def create
    @car = Car.find(params[:car_id])
    @journey = @car.journeys.build(journey_params)
    @journey.user = current_user
    authorize @journey
    if @journey.save
      redirect_to journey_path(@journey)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @journey.update(journey_params)
    email_all_passengers(@journey.passengers) unless @journey.completed?
    authorize @journey
    redirect_to journey_path(@journey)
  end

  def destroy
    @journey.destroy
    authorize @journey
    redirect_to journeys_path
  end

  private

  def driver_journey
    authorize @journey
  end

  def set_journey
    @journey = Journey.find(params[:id])
    authorize @journey
  end

  def journey_params
    params.require(:journey).permit(
      :seats_available,
      :pick_up_time,
      :completed,
      pick_up_location_attributes: [ :address ],
      drop_off_location_attributes: [ :address ]
    )
  end

  def email_all_passengers(passengers)
    passengers.each do |passenger|
      JourneyMailer.update_journey(passenger).deliver_now
    end
  end

  def set_passenger_locations
    @passenger_locations = PassengerLocation.all
  end

  def create_waypoints
    @waypoints = @journey.passengers.map do |passenger|
      { location: passenger.passenger_location.address.to_s }
    end
  end
end
