class PassengerMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def confirmation_of_booking(passenger)
    @user = passenger.user
    @journey = passenger.journey
    @car = @journey.car

    mail(to: @user.email, subject: 'Booking confirmation')
  end
end
