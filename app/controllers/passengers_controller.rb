class PassengersController < ApplicationController

  before_action :find_journey, only: [:create, :update]

  # def new
  #   @passenger = Passenger.new
  #   authorize @passenger
  # end

  def create
    @passenger = Passenger.new(passenger_params)
    @passenger.user = current_user
    @passenger.journey = @journey
    if @passenger.save
      PassengerMailer.confirmation_of_booking(@passenger).deliver_now # This sends email confirmation to the passenger
      PassengerMailer.new_passenger(@passenger).deliver_now # This send a notification to the driver
    else
      flash[:alert] = "There was an error booking you on this journey!"
    end
    redirect_to journey_path(@journey)
    authorize @passenger
  end

  def update
    @passenger = Passenger.find(params[:id])
    @passenger.update(passenger_params)
    authorize @passenger
    redirect_to journey_path(@journey)
  end

  private

  def find_journey
    @journey = Journey.find(params[:journey_id])
  end



  def passenger_params
    params.require(:passenger).permit(:driver_rating, :passenger_rating)
  end
end

