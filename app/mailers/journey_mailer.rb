class JourneyMailer < ApplicationMailer

  def confirmation_of_booking(recipient, journey)
    @user = journey.user
    @journey = journey
    @car = @journey.car
    
    
    from = select_from

    mail(from: from, to: recipient, subject: 'Booking confirmation')

  end


  def update_journey(recipient, journey)
    @user = journey.user
    @journey = journey
    @car = @journey.car
    
    from = select_from

    mail(from: from, to: recipient, subject: 'Your teacher booking have changed')
    
  end
  
  def select_from
    if @user.domain == 'http://www.diverlang.com' || @user.domain == 'http://diverlang.com'
      'contact@diverlang.com'
    else
      'contact@helloveronica.com'
    end  
  end 

end
