class JourneysController < ApplicationController
  before_action :set_journey, only:[:show, :edit, :update, :destroy, :driver_journey]
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  def index
    @journeys = policy_scope(Journey)
    @journeys.sort { |x,y| x.pick_up_time <=> y.pick_up_time }
  end

  def show
    @journey = Journey.find(params[:id])
    @passenger = @journey.passengers.build(user: current_user)

    @hash = Gmaps4rails.build_markers([ @journey.pick_up_location, @journey.drop_off_location ]) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
    end
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
    @car = Car.find(params[:car_id])
    @journey.car = @car
    authorize @journey
  end

  def update
    @journey.update(journey_params)
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
end
