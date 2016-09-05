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
  end

  def create
    @car = Car.new(car_params)
    @user = current_user
    @car.user = @user
    authorize @car
    if @car.save
      redirect_to dashboard_path
    else
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
    params.require(:car).permit(:make, :name, :vrn, :colour)
  end
end
