class CreateAvailabilities < ActiveRecord::Migration[5.0]
  def change
    create_table :availabilities do |t|
      t.string :weekday
      t.time :start
      t.time :finish
      t.references :car, foreign_key: true

      t.timestamps
    end
  end
end
