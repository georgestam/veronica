module Journeys
  module Creation
    class JourneyMailer < ApplicationMailer

      def confirmation_of_booking(recipient, journey)
        @user = journey.user
        @journey = journey
        @car = @journey.car

        mail(from: from, to: recipient, subject: 'Booking confirmation')

      end

      def update_journey(recipient, journey)
        @user = journey.user
        @journey = journey
        @car = @journey.car

        mail(from: from, to: recipient, subject: 'Your teacher booking have changed')
        
      end
      
      def from
        if @user.diverlang?
          'cristina@helloveronica.com'
        else
          'cristina@helloveronica.com'
        end  
      end 

    end
  end
end
