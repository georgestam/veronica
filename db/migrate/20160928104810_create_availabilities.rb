class CreateAvailabilities < ActiveRecord::Migration[5.0]
  def change
    create_table :availabilities do |t|
      t.string :migration
      t.string :weekday
      t.datetime :start
      t.datetime :finish
      t.references :car, foreign_key: true

      t.timestamps
    end
  end
end
