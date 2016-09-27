class CreatePassengers < ActiveRecord::Migration[5.0]
  def change
    create_table :passengers do |t|
      t.references :user, foreign_key: true
      t.references :journey, foreign_key: true

      t.timestamps

      t.integer :driver_rating
      t.integer :passenger_rating

      t.integer :driver_review
      t.integer :passenger_review

    end
  end
end
