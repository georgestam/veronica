class Api::V1::JourneysController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_journey, only: [ :show, :update]

  def index
    @journeys = policy_scope(Journey)
  end

  def show
  end

  def update
    if @journey.update(journey_params)
      render :show
    else
      render_error
    end
  end

  def driver
    @journeys_as_driver = Journey.where(user: current_user)
    authorize @journeys_as_driver
  end

  def passenger
    @journeys_as_passenger = Passenger.where(user: current_user).map{|passenger| passenger.journey}
  end

  private

  def set_journey
    @journey = Journey.find(params[:id])
    authorize @journey  # For Pundit
  end

  def journey_params
    params.require(:journey).permit(
      :seats_available,
      :pick_up_time,
      pick_up_location_attributes: [ :address ],
      drop_off_location_attributes: [ :address ]
    )
  end

  def render_error
    render json: { errors: @journey.errors.full_messages },
      status: :unprocessable_entity
  end
end
