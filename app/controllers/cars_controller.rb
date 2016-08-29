class CarsController < ApplicationController

  before_action :find_car, only: [:show, :edit, :update, :destroy]
  before_action :find_user, only: [:show, :update, :destroy]

  def index
    @cars = Car.all
  end

  def show
    @user = @car.user
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @user = current_user
    @car.user = @user
    if @car.save
      redirect_to profile_path(@user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @car.update(car_params)
    redirect_to profile_path(@user)
  end

  def destroy
    @car.destroy
    redirect_to profile_path(@user)
  end

  private

  def find_car
    @car = Car.find(params[:id])
  end

  def find_user
    @user = @car.user
  end

  def car_params
    params.require(:car).permit(:make, :model, :vrn, :colour)
  end
end
