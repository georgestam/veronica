class JourneysController < ApplicationController
  before_action :set_journey, only:[:show, :edit, :update, :destroy]

  def index
    @journeys = Journey.all
  end

  def show
    @journeys = Journey.where.not(pick_up_latitude: nil, pick_up_longitude: nil, drop_off_latitude: nil, drop_off_longitude: nil)
    @hash = Gmaps4rails.build_markers(@journeys) do |journey, marker|
      marker.lat  journey.pick_up_latitude
      marker.lng journey.pick_up_longitude
      # marker.lat journey.drop_off_latitude
      # marker.lng journey.drop_off_longitude
    end
  end

  def new
    @car = Car.find(params[:car_id])
    @journey = Journey.new
    @journey.car = @car
  end

  def create
    @journey = Journey.new(journey_params)
    @journey.car = Car.find(params[:car_id])
    @journey.user = current_user
    if @journey.save
      redirect_to journey_path(@journey)
    else
      render :new
    end
  end

  def edit
    @car = Car.find(params[:car_id])
    @journey.car = @car
  end

  def update
    @journey.update(journey_params)
    redirect_to journey_path(@journey)
  end

  def destroy
    @journey.destroy
    redirect_to journeys_path
  end

  private

  def set_journey
    @journey = Journey.find(params[:id])
  end

  def journey_params
    params.require(:journey).permit(:seats_available, :pick_up_time, :pick_up_location, :drop_off_location)
  end
end
