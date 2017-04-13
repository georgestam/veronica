class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :state, null: false
      t.integer :price_hour, null: false
      t.references :journey, foreign_key: true, null: false
      t.integer :minutes, null: false
      t.monetize :consumer_total, null: false
      t.json :payment
      
      t.datetime :approved_at
      t.datetime :rejected_at
      t.string :stripe_charge_id
      t.string :stripe_refund_id
      t.datetime :stripe_charged_at
      t.datetime :stripe_refunded_at
      
      t.integer :invoice_number
      t.integer :invoice_year

      t.timestamps
    end
  end
end
