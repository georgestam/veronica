class ImpartedHoursController < ApplicationController

  before_action :find_journey, only: [:index, :create, :destroy ]
  before_action :find_imparted_hour, only: [:destroy]

  def index
    @imparted_hours = ImpartedHour.where(journey: @journey)
    policy_scope(@imparted_hours)
  end
  
  def create
    @imparted_hour = ImpartedHour.new(imparted_hour_params)
    @imparted_hour.journey = @journey
    @imparted_hour.record_price
    
    authorize @imparted_hour

    if @imparted_hour.save
      flash[:notice] = "Your class have been recorded!"
      redirect_to dashboard_path
      
    else
      flash[:alert] = "There was an error writting your hours!"
      redirect_to dashboard_path
    end

  end

  def destroy
    @imparted_hour.destroy!
    redirect_to dashboard_path
  end

  private

  def find_journey
    @journey = Journey.find(params[:journey_id])
  end

  def imparted_hour_params 
    params.require(:imparted_hour).permit(:journey, :minutes, :date)
  end
  
  def find_imparted_hour
    @imparted_hour = ImpartedHour.find(params[:id])
    authorize @imparted_hour
  end

end
