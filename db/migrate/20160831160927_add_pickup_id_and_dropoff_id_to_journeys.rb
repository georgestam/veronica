class AddPickupIdAndDropoffIdToJourneys < ActiveRecord::Migration[5.0]
  def change
    add_column :journeys, :pick_up_location_id, :integer
    add_column :journeys, :drop_off_location_id, :integer
  end
end
