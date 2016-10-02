class CarsController < ApplicationController

  before_action :find_car, only: [:show, :edit, :update, :destroy]
  before_action :find_user, only: [:show, :update, :destroy]

  def index
    @cars = policy_scope(Car)
  end

  def show
    @user = @car.user
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
    if @user.cars.count < 2 && @car.save
      if user_signed_in? && @user.photo == nil
      redirect_to edit_profile_path(@user)
      else
      redirect_to dashboard_path
      end

    elsif @user.cars.count > 2
      flash[:exceed_car_limit] = "You can only have one teacher profile."
      render :new
    else
      raise
      render :new
    end
  end

  def edit
  end

  def update
    @car.update(car_params)
    redirect_to dashboard_path
  end

  def destroy
    @car.destroy
    redirect_to dashboard_path
  end

  private

  def find_car
    @car = Car.find(params[:id])
    authorize @car
  end

  def find_user
    @user = @car.user
  end

  def car_params
    params.require(:car).permit(:bio, :video_URL, :travel_distance, :price_hour)
  end
end
