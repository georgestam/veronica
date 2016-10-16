class ProfilesController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update]
  before_action :find_car, only: [:teacher]
  skip_before_action :authenticate_user!, only: [ :teacher]

  def index


  end

  def show
    @cars = Car.where(user: @user)

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
    @teacher = false

    if @user.cars[0] == nil


    @journeys = Journey.where(user: @user)

    calculate_avg_rating

    @passengers = Passenger.where(journey_id: Journey.where(user: @car))


    else

    @teacher = true
    cars= Car.where(user: @user)
    @car= cars[0]
    @availabilities = Availability.where(car: @car)

    verifications
    calculate_account_progress # This will return @progress

    map_availabilities

    @journeys = Journey.where(car: @car)

    @kids = 0

    @journeys.each do |journey|
       @kids += journey.seats_available
    end

    calculate_avg_rating

    @passengers = Passenger.where(journey_id: Journey.where(car: @car))

    end

  end

  def teacher


    @availabilities = Availability.where(car: @car)

    verifications
    calculate_account_progress # This will return @progress

    map_availabilities

    @journeys = Journey.where(car: @car)

    @kids = 0

    @journeys.each do |journey|
       @kids += journey.seats_available
    end

    calculate_avg_rating

    @passengers = Passenger.where(journey_id: Journey.where(car: @car))
    # @reviews = Review.where(booking_id: Booking.where(profile: @profile).pluck(:id))
    #
    @hash = Gmaps4rails.build_markers(@car.user) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow user.first_name
    end

  end

  private

  def find_user
    @user = User.find(params[:id])
    authorize @user
  end

  def find_car
    @car = Car.find(params[:id])
    authorize @car
  end

  def user_params
    params.require(:user).permit(:photo, :id_document, :first_name, :last_name, :email, :phone_number, :description, :gender, :facebook_URL, :linkedin_URL, :address, :date_of_birth)
  end

  def calculate_avg_rating
    @ratings = []
    @comments = []

    @journeys.each do |journey|
      journey.passengers.each do |passenger|
        unless passenger.driver_rating.nil?
          #  This will remove any future journeys as the driver will not have been rated, therefore rating = nil
          @ratings << passenger.driver_rating
        end
      end
    end

    @avg_rating = 0
    @avg_rating = @ratings.inject(0){|sum,x| sum + x } / @ratings.count if @ratings.count != 0

    @journeys.each do |journey|
      journey.passengers.each do |passenger|
        unless passenger.driver_review.nil?
          #  This will remove any future journeys as the driver will not have been rated, therefore rating = nil
          @comments << passenger.driver_review
        end
      end
    end

  end

  def calculate_account_progress
    @progress = 0
    @progress += 5 if @email_verified
    @progress += 5 if @photo_verified
    @progress += 10 if @address_verified
    @progress += 10 if @availability_verified
    @progress += 15 if @upload_video
    @progress += 10 if @facebook_URL_verified
    @progress += 10 if @linkedin_URL_verified
    @progress += 20 if @id_document_verified
    @progress += 15 if @bank_verified

  end

  def verifications
    @email_verified = true if @car.user.confirmed?
    @photo_verified = true if @car.user.photo
    @address_verified = true if @car.user.address
    @availability_verified = true unless @car.user.cars[0].availabilities.empty?
    @upload_video = true if @car.user.cars[0].video_URL != ""
    @facebook_URL_verified = true if @car.user.facebook_URL != ""
    @linkedin_URL_verified = true if @car.user.linkedin_URL != ""
    @id_document_verified = true if @car.user.id_document
    @bank_verified = true if @car.user.bank_account

    manual_check_pending

  end

  def manual_check_pending

    @manual_check = false

    if @car.user.passport_verif == false && @id_document_verified
      @manual_check = true
    elsif @car.user.facebook_verif == false && @facebook_URL_verified
      @manual_check = true
    elsif @car.user.linkedin_verif == false && @linkedin_URL_verified
      @manual_check = true
    end


  end

  def map_availabilities

    monday = []
    tuesday = []
    wednesday = []
    thursday = []
    friday = []
    saturday = []
    sunday = []

    @availabilities.each do |aval|
      if aval.weekday == 'Monday'
        monday << aval
      elsif aval.weekday == 'Tuesday'
        tuesday << aval
      elsif aval.weekday == 'Wednesday'
        wednesday << aval
      elsif aval.weekday == 'Thursday'
        thursday << aval
      elsif aval.weekday == 'Friday'
        friday << aval
      elsif aval.weekday == 'Saturday'
        saturday << aval
      elsif aval.weekday == 'Sunday'
        sunday << aval
      end
    end

    @days = [monday, tuesday, wednesday, thursday,friday, saturday, sunday ]



  end

end
