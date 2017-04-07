module Orders
  module Creation
    class ParentNotificationMailer < ApplicationMailer
      
      def perform order
        @order = order
        @p1 = t('.p1', teacher: @order.journey.car.user.first_name, parent: @order.journey.user.first_name)
        @p2 = t('.p2', amount: @order.consumer_total)
        @p3 = t('.p3')
        @p4 = t('.p4')
        @cta_url = @order.payment_link
        mail(to: order.journey.user.email, subject: t('.subject', teacher: @order.journey.car.user.first_name, id: order.id))
      end
      
    end
  end
end

