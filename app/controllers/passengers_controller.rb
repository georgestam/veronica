class PassengersController < ApplicationController

  before_action :find_journey, only: [:create, :update]
  before_action :find_passenger, only: :update

  def create
    @passenger = Passenger.new
    @passenger.user = current_user
    @passenger.journey = @journey
    authorize @passenger
    if @passenger.save
      PassengerMailer.confirmation_of_booking(@passenger).deliver_now # This sends email confirmation to the passenger
      PassengerMailer.new_passenger(@passenger).deliver_now # This send a notification to the driver
    else
      flash[:alert] = "There was an error booking you on this journey!"
    end
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

