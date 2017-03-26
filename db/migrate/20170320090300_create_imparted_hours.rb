class CreateImpartedHours < ActiveRecord::Migration[5.0]
  def change
    create_table :imparted_hours do |t|
      t.integer :minutes,         :null => false             
      t.datetime :date                
      t.integer :price_cents,     :null => false             
      t.references :journey,   foreign_key: true

      t.timestamps
    end
  end
end
