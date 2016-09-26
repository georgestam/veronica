class CreateJourneys < ActiveRecord::Migration[5.0]
  def change
    create_table :journeys do |t|
      t.references :user, foreign_key: true
      t.references :car, foreign_key: true
      t.boolean :completed


      t.timestamps

      # t.references :location, foreign_key: true
      t.string :num_of_students
      t.datetime :start_time
      t.datetime :finish_time
      t.string :payment


      # delete
      t.integer :seats_available
      t.datetime :pick_up_time
      t.string :pick_up_location
      t.string :drop_off_location

      t.float :pick_up_latitude
      t.float :pick_up_longitude
      t.float :drop_off_latitude
      t.float :drop_off_longitude



    end
  end
end
