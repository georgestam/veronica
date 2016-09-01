class AddCoordinatesForBothLocationsToJourneys < ActiveRecord::Migration[5.0]
  def change
    add_column :journeys, :pick_up_latitude, :float
    add_column :journeys, :pick_up_longitude, :float
    add_column :journeys, :drop_off_latitude, :float
    add_column :journeys, :drop_off_longitude, :float
  end
end
