class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :description, :text
    add_column :users, :gender, :string

    add_column :users, :address, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :city, :string
    add_column :users, :country, :string

    add_column :users, :linkedin_URL, :string
    add_column :users, :facebook_URL, :string
    add_column :users, :bank_account, :string

    add_column :users, :date_of_birth, :datetime

    add_column :users, :passport_verif, :boolean
    add_column :users, :interview_verif, :boolean
    add_column :users, :linkedin_verif, :boolean
    add_column :users, :facebook_verif, :boolean

  end
end
