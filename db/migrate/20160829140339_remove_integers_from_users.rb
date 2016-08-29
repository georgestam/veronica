class RemoveIntegersFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :phone_number
    remove_column :users, :student_id
  end
end
