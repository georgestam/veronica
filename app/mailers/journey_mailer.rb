class JourneyMailer < ApplicationMailer

  def update_journey(passenger)
    @user = passenger.user # This is the passenger
    @journey = passenger.journey
    @driver = @journey.user # This is the driver
    @car = @journey.car

    mail(to: @user.email, subject: 'Change to your journey')
  end

end
