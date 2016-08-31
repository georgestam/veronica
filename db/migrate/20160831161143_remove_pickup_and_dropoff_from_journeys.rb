class RemovePickupAndDropoffFromJourneys < ActiveRecord::Migration[5.0]
  def change
    remove_column :journeys, :pick_up_location, :string
    remove_column :journeys, :drop_off_location, :string
  end
end
