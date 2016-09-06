module JourneysHelper
  def on_journey?(journey)
    journey.passengers.pluck(:user_id).include? current_user.id
  end
end
