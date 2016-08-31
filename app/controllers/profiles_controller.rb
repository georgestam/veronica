class ProfilesController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update]

  def show
    @cars = Car.where(user: @user)
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to profile_path(@user)
  end

  def dashboard
    @user = current_user
    @journeys = Journey.where(user: @user)
    calculate_avg_rating
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:photo, :first_name, :last_name, :email, :phone_number, :description, :gender, :student_id, :date_of_birth, :music_habits, :speaking_habits, :year_of_study, :uni_course, :smoking)
  end

  def calculate_avg_rating
    ratings = []

    @journeys.each do |journey|
      journeys.passengers.each do |passenger|
        ratings << passenger.driver_rating
      end
    end

    @avg_rating = ratings.inject(0){|sum,x| sum + x } / ratings.count if ratings.count != 0
  end
end
