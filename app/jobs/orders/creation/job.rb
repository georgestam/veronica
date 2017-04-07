module Orders
  module Creation
    class Job < ApplicationJob
      
      def perform model_name, order_id
        order = Order.find order_id
        
        teacher_mail = Orders::Creation::ParentNotificationMailer.perform(order)
      
        teacher_mail.deliver_now
      end
      
    end
  end
end