class Api::V1::JourneysController < Api::V1::BaseController
  before_action :set_journey, only: [ :show ]

  def show
  end

  private

  def set_journey
    @journey = Journey.find(params[:id])
    authorize @journey  # For Pundit
  end
end
