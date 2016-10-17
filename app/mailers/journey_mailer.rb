class JourneyMailer < ApplicationMailer

  def confirmation_of_booking(journey)
    @user = journey.user
    @journey = journey
    @car = @journey.car

    mail(to: @user.email, subject: 'Booking confirmation')
    mail(to: @car.user.email, subject: 'Booking confirmation')

  end


  def update_journey(journey)
    @user = journey.user
    @journey = journey
    @car = @journey.car

    mail(to: @user.email, subject: 'Your teacher booking have changed')
    mail(to: @car.user.email, subject: 'Your teacher booking have changed')
  end

end
