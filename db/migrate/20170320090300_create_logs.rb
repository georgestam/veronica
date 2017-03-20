class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.integer :minutes                 
      t.datetime :date                
      t.integer :minutes_paid          
      t.datetime :date_paid         
      t.references :journey,   foreign_key: true

      t.timestamps
    end
  end
end
