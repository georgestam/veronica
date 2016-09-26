
#remove

class CreatePassengerLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :passenger_locations do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
    end

    add_column :passengers, :passenger_location_id, :integer, null: true

    add_foreign_key :passengers, :passenger_locations, column: :passenger_location_id, foreign_key: 'passenger_location_id'
  end
end
