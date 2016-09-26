class CreatePassengers < ActiveRecord::Migration[5.0]
  def change
    create_table :passengers do |t|
      t.references :user, foreign_key: true
      t.references :journey, foreign_key: true

      t.timestamps

      t.integer :parent_rating
      t.integer :parent_review
      t.integer :teacher_rating
      t.integer :teacher_review

      # delete

      t.integer :driver_rating
      t.integer :passenger_rating

    end
  end
end
