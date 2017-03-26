class JourneysController < ApplicationController
  before_action :set_journey, only: [:show, :edit, :update, :destroy, :driver_journey]
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @journeys = policy_scope(Journey)
    @available_journeys = @journeys.select{ |journey| journey.remaining_seats.positive? && journey.completed != true}
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
      # send booking to parent https://subvisual.co/blog/posts/66-sending-multiple-emails-with-actionmailer
      JourneyMailer.confirmation_of_booking(@journey.user.email, @journey).deliver_now
      # send booking to teacher
      # JourneyMailer.confirmation_of_booking(@journey.car.user.email, @journey).deliver_now
      # send booking to admin
      JourneyMailer.confirmation_of_booking('diverlang.adm@gmail.com', @journey).deliver_now
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
    authorize @journey
  end

  def update
    @journey.update(journey_params)
    JourneyMailer.update_journey(@journey).deliver_now unless @journey.completed?
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

  def create_waypoints
    @waypoints = @journey.passengers.map do |passenger|
      { location: passenger.passenger_location.address.to_s }
    end
  end
end
