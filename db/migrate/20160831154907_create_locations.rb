class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
    end




    # remove
    remove_column :journeys, :pick_up_location, :string
    remove_column :journeys, :drop_off_location, :string
    add_column :journeys, :pick_up_location_id, :integer
    add_column :journeys, :drop_off_location_id, :integer

    add_foreign_key :journeys, :locations, column: :pick_up_location_id, foreign_key: 'pick_up_location_id'
    add_foreign_key :journeys, :locations, column: :drop_off_location_id, foreign_key: 'drop_off_location_id'
  end
end
