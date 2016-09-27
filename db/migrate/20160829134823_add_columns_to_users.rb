class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :integer
    add_column :users, :description, :text
    add_column :users, :gender, :string

    add_column :users, :teacher, :boolean
    add_column :users, :linkedin_URL, :string
    add_column :users, :Facebook_URL, :string
    add_column :users, :bank_account, :string
    add_column :users, :passport_verification, :string





  end
end
