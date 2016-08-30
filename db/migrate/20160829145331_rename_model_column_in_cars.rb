class RenameModelColumnInCars < ActiveRecord::Migration[5.0]
  def change
    rename_column :cars, :model, :name
  end
end
