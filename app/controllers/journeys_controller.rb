class JourneysController < ApplicationController
  before_action :set_journey, only:[:show, :edit, :update, :destroy, :driver_journey]
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  def index
    @journeys = policy_scope(Journey)
    @available_journeys = @journeys.select{ |journey| journey.remaining_seats > 0 && journey.completed != true}
    # @available_journeys.sort { |x,y| x.pick_up_time <=> y.pick_up_time }
  end

  def show
    @journey = Journey.find(params[:id])

    @car = @journey.car
    create_waypoints # This will create an array of waypoints to give to the map
  end

  def new
    @car = Car.find(params[:car_id])
    @journey = Journey.new
    @journey.car = @car


    authorize @journey
  end

  def create
    @car = Car.find(params[:car_id])
    @journey = @car.journeys.build(journey_params)
    @journey.user = current_user
    authorize @journey
    if @journey.save
      redirect_to dashboard_path
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
    redirect_to dashboard_path
  end

  def destroy
    @journey.destroy
    authorize @journey
    redirect_to dashboard_path
  end

  private

  def driver_journey
    authorize @journey
  end

  def set_journey
    @journey = Journey.find(params[:id])

  end

  def journey_params
    params.require(:journey).permit(

      :completed,
      :pick_up_time,
      :seats_available,
      :address,
      :latitude,
      :longitude,
      :duration,
      :payment
    )
  end

  def email_all_passengers(passengers)
    passengers.each do |passenger|
      JourneyMailer.update_journey(passenger).deliver_now
    end
  end


  def create_waypoints
    @waypoints = @journey.passengers.map do |passenger|
      { location: passenger.passenger_location.address.to_s }
    end
  end
end
