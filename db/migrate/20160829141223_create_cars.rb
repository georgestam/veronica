class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.references :user, foreign_key: true

      t.string :bio
      t.string :video_URL
      t.string :available_time
      t.string :travel_distance
      t.string :price_hour

      t.timestamps

      # delete
      t.string :make
      t.string :name
      t.string :vrn
      t.string :colour

    end
  end
end
