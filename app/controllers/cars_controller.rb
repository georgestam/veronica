class CarsController < ApplicationController

  before_action :find_car, only: [:edit, :update, :destroy]
  before_action :find_user, only: [:update, :destroy]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @cars = policy_scope(Car)

    # extract search parameters and use defualts if not entered by user
    @min_price = params[:price_range] ? params[:price_range].split(",").map(&:to_i)[0] : 0
    @max_price = params[:price_range] ? params[:price_range].split(",").map(&:to_i)[1] : 1000
    @max_distance = params[:max_distance] && params[:max_distance] != "" ? params[:max_distance] : 10_000
    @your_location = params[:your_location] && params[:your_location] != "" ? params[:your_location] : "London"

    user_ids = User.near(@your_location, @max_distance).map(&:id)
    @cars = Car.where(user_id: user_ids)

    # @car = Car.where(price_hour: @min_price..@max_price, user_id: user_ids)

    @hash = Gmaps4rails.build_markers(@cars) do |car, marker|
      marker.lat car.user.latitude
      marker.lng car.user.longitude
      link = view_context.link_to (car.user.first_name).to_s, teacher_profile_path(car), class: "no-decoration"
      description = link.to_s
      marker.infowindow description
      # marker.picture({
      #: ActionController::Base.helpers.image_path("vero/logo.png"),
      # width: 30,
      # height: 30
      # })
    end

  end

  def new
    @car = Car.new
    authorize @car
    @user = current_user
  end

  def create
    @car = Car.new(car_params)
    @user = current_user
    @car.user = @user
    authorize @car
    if @user.cars.count < 1 && @car.save
      if user_signed_in? && @user.photo.nil?
      redirect_to edit_profile_path(@user)
      else
      redirect_to dashboard_path
      end

    elsif @user.cars.count > 1
      flash[:exceed_car_limit] = "You can only have one teacher profile."
      render :new
    else

      render :new
    end
  end

  def edit
    authorize @car
  end

  def update
    authorize @car
    @car.update(car_params)
    redirect_to teacher_profile_path(@car)
  end

  def destroy
    @car.destroy
    redirect_to dashboard_path
  end

  private

  def find_car
    @car = Car.find(params[:id])
  end

  def find_user
    @user = @car.user
  end

  def car_params
    params.require(:car).permit(:bio, :video_url, :travel_distance, :price_hour)
  end

  # copy from profile controllers

  def calculate_avg_rating
    @ratings = []
    @comments = []

    @journeys.each do |journey|
      journey.passengers.each do |passenger|
        unless passenger.driver_rating.nil?
          #  This will remove any future journeys as the driver will not have been rated, therefore rating = nil
          @ratings << passenger.driver_rating
        end
      end
    end

    @avg_rating = @ratings.inject(0){|sum, x| sum + x } / @ratings.count if @ratings.count != 0

  end

end
