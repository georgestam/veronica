class JourneyMailer < ApplicationMailer

  def confirmation_of_booking(journey)
    @user = journey.user
    @journey = journey
    @car = @journey.car
    
    if @user.domain == 'http://www.diverlang.com' || @user.domain == 'http://diverlang.com'
      mail(from: 'contact@diverlang.com', to: @user.email, subject: 'Booking confirmation')
      mail(from: 'contact@diverlang.com', to: @car.user.email, subject: 'Booking confirmation')
    else
      mail(from: 'contact@helloveronica.com', to: @user.email, subject: 'Booking confirmation')
      mail(from: 'contact@helloveronica.com', to: @car.user.email, subject: 'Booking confirmation')
    end 

  end


  def update_journey(journey)
    @user = journey.user
    @journey = journey
    @car = @journey.car

    if @user.domain == 'http://www.diverlang.com' || @user.domain == 'http://diverlang.com'
      mail(from: 'contact@diverlang.com', to: @user.email, subject: 'Your teacher booking have changed')
      mail(from: 'contact@diverlang.com', to: @car.user.email, subject: 'Your teacher booking have changed')
    else
      mail(from: 'contact@helloveronica.com', to: @user.email, subject: 'Your teacher booking have changed')
      mail(from: 'contact@helloveronica.com', to: @car.user.email, subject: 'Your teacher booking have changed')
    end  
    
    
  end

end
