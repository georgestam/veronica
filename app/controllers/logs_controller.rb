class LogsController < ApplicationController

  before_action :find_journey, only: [:index, :create, :destroy ]
  before_action :find_log, only: [:destroy]

  def index
    @logs = Log.where(journey: @journey)
    @logs_paid = @logs.where.not(minutes_paid: nil)
    policy_scope(@logs)
  end
  
  def create
    @log = Log.new(log_params)
    @log.journey = @journey
    authorize @log

    if @log.save
      redirect_to dashboard_path

    else
      flash[:alert] = "There was an error writting your hours!"
      redirect_to dashboard_path
    end

  end

  def destroy
    @log.destroy
    redirect_to dashboard_path
  end

  private

  def find_journey
    @journey = Journey.find(params[:journey_id])
  end

  def log_params 
    params.require(:log).permit(:journey, :minutes, :date)
  end
  
  def find_log
    @log = Log.find(params[:id])
    authorize @log
  end

end
