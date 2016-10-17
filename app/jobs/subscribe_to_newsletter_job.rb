class SubscribeToNewsletterJob < ApplicationJob
  def perform(user_id)
    user = User.find(user_id)
    SubscribeToNewsletterService.new(user).call
  end
end
