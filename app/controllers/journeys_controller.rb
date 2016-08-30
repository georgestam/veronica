class JourneysController < ApplicationController
  before_action :set_journey, only:[:show, :edit, :update, :destroy]

  def index
    @journeys = Journey.all
  end

  def show
  end

  def new
    @journey = Journey.new
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
  end

  def update
    @journey.update(journey_params)
    redirect_to journey_path(@journey)
  end

  def destroy
    @journey.destroy
  end

  private

  def set_journey
    @journey = Journey.find(params[:id])
  end

  def journey_params
    params.require(:journey).permit(:seats_available, :pick_up_time, :pick_up_location, :drop_off_location)
  end
end
