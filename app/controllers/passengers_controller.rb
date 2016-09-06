class PassengersController < ApplicationController

  before_action :find_journey, only: [:create, :update]
  before_action :find_passenger, only: :update

  def create
    @passenger = Passenger.new
    @passenger.user = current_user
    @passenger.journey = @journey
    authorize @passenger
    @passenger.save
    redirect_to journey_path(@journey)
  end

  def update
    @passenger.update(passenger_params)
    redirect_to journey_path(@journey)
  end

  private

  def find_journey
    @journey = Journey.find(params[:journey_id])
  end

  def find_passenger
    @passenger = Passenger.find(params[:id])
    authorize @passenger
  end

  def passenger_params
    params.require(:passenger).permit(policy(@passenger).permitted_attributes)
  end
end

