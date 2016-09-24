class ProfilesController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update]

  def show
    @cars = Car.where(user: @user)

    create_journey_arrays
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to dashboard_path
  end

  def dashboard
    @user = current_user
    authorize @user

    create_journey_arrays

    calculate_account_progress # This will return @progress
    verifications
  end

  private

  def find_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:photo, :first_name, :last_name, :email, :phone_number, :description, :gender, :student_id, :date_of_birth, :music_habits, :speaking_habits, :year_of_study, :uni_course, :smoking)
  end

  def calculate_avg_rating
    ratings = []

    @journeys.each do |journey|
      journey.passengers.each do |passenger|
        unless passenger.driver_rating.nil?
          #  This will remove any future journeys as the driver will not have been rated, therefore rating = nil
          ratings << passenger.driver_rating
        end
      end
    end

    @avg_rating = ratings.inject(0){|sum,x| sum + x } / ratings.count if ratings.count != 0
  end

  def calculate_account_progress
    @progress = 0
    @progress += 20 if @user.confirmed? # Email confirmation
    # progress + 20 if payment confirmed
    # progress + 20 if student_id confirmed
    @progress += 20 unless @user.cars.empty?
  end

  def verifications
    @email_verification = true if @user.confirmed?
    @payment_verification = false # Need to implement payment
    @student_id_verification = false # Need to implement student verificaiton
    @car_verification = true unless @user.cars.empty?
  end

  def create_journey_arrays
    @journeys = Journey.where(user: @user) #  Needed to calculate the avg_rating
    calculate_avg_rating # This will return @avg-rating

    @journeys_as_passenger = Passenger.where(user: current_user).map{|passenger| passenger.journey}
    @journeys_as_driver = Journey.where(user: current_user)
  end
end
