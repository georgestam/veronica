class PassengersController < ApplicationController

  before_action :find_journey, only: [:new, :create, :update]
  before_action :find_passenger, only: [:update, :destroy]

  def new
    @passenger = Passenger.new
    @passenger.user = current_user
    authorize @passenger

  end

  def create
    @passenger = Passenger.new(passenger_params_to_create)
    @passenger.journey = @journey
    @passenger.user = current_user
    @journey.completed = true
    authorize @passenger

    if @passenger.save && @journey.save


      redirect_to dashboard_path

    else
      flash[:alert] = "There was an error writting the review!"
      render :new
    end

  end

  def update
    @passenger.update(passenger_params)
    redirect_to journey_path(@journey)
  end

  def destroy
    @passenger.destroy
    redirect_to journey_path(@passenger.journey)
  end

  private

  def find_journey
    @journey = Journey.find(params[:journey_id])
  end

  def find_passenger
    @passenger = Passenger.find(params[:id])
    authorize @passenger
  end

  def passenger_params_to_create # Only used for update

    params.require(:passenger).permit(:journey, :driver_rating, :passenger_rating, :driver_review, :passenger_review)

  end

  def passenger_params # Only used for update
    params.require(:passenger).permit(policy(@passenger).permitted_attributes)
  end
end

