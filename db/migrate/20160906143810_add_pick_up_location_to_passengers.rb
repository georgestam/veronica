class AddPickUpLocationToPassengers < ActiveRecord::Migration[5.0]
  def change
    add_column :passengers, :pick_up_location_id, :integer
    add_foreign_key :passengers, :locations, column: :pick_up_location_id, foreign_key: 'pick_up_location_id'
  end
end
