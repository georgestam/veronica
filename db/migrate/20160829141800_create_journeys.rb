class CreateJourneys < ActiveRecord::Migration[5.0]
  def change
    create_table :journeys do |t|
      t.references :user, foreign_key: true
      t.references :car, foreign_key: true


      t.boolean :completed


      t.timestamps

      # t.references :location, foreign_key: true

      t.string :Duration
      t.string :payment

      t.datetime :pick_up_time
      t.integer :seats_available


    end
  end
end
