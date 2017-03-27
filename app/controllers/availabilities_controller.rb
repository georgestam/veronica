class AvailabilitiesController < ApplicationController

  before_action :find_car, only: [:create, :destroy]
  before_action :find_availability, only: [:destroy]

  def new
    @availability = Availability.new
    authorize @availability
  end

  def create
    @availability = Availability.new(availability_params)
    @availability.car = @car
    authorize @availability
    if  @availability.save
      flash[:message] = t("create_new_time")
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def destroy
    authorize @availability
    @availability.destroy
    redirect_to dashboard_path
  end

  private

  def find_car
    @car = Car.find(params[:car_id])
  end

  def find_availability
    @availability = Availability.find(params[:id])
  end

  def availability_params
    params.require(:availability).permit(:weekday, :start, :finish)
  end

end
