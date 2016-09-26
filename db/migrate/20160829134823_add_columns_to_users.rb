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


    # to remove
    add_column :users, :student_id, :integer
    add_column :users, :date_of_birth, :datetime
    add_column :users, :music_habits, :string
    add_column :users, :speaking_habits, :string
    add_column :users, :year_of_study, :integer
    add_column :users, :uni_course, :string
    add_column :users, :smoking, :boolean


  end
end
