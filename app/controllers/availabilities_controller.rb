class AvailabilitiesController < ApplicationController

  before_action :find_car, only: [:show, :edit, :update, :destroy]
  before_action :find_avaliability, only: [:show, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @car = Avaliability.new
    authorize @avaliability
    @user = current_user
  end

  def create
    @avaliability = Avaliability.new(avaliability_params)
    @avaliability.car = @car
    authorize @avaliability
    if  @avaliability.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @avaliability.update(avaliability_params)
    redirect_to dashboard_path
  end

  def destroy
    @avaliability.destroy
    redirect_to dashboard_path
  end

  private

  def find_car
    @car = Car.find(params[:car_id])
  end

  def find_avaliability
    @avaliability = Avaliability.find(params[:id])
  end

  def avaliability_params
    params.require(:avaliability).permit(:weekday, :start, :finish, :car_id)
  end


end
