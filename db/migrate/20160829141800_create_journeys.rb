class CreateJourneys < ActiveRecord::Migration[5.0]
  def change
    create_table :journeys do |t|
      t.integer :seats_available
      t.references :user, foreign_key: true
      t.references :car, foreign_key: true
      t.datetime :pick_up_time
      t.string :pick_up_location
      t.string :drop_off_location
      t.boolean :completed

      t.timestamps
    end
  end
end
