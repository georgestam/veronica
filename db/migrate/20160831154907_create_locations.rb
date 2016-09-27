class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
    end

    # add foreign key in journey table as pick_up_location_id rather than location_id
    add_column :journeys, :pick_up_location_id, :integer
    add_foreign_key :journeys, :locations, column: :pick_up_location_id, foreign_key: 'pick_up_location_id'

  end
end
