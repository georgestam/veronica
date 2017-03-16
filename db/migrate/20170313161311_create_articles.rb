class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title,            null: false
      t.string :description,      null: false
      t.string :locale,           null: false
      t.string :slug,             null: false
      
      t.boolean :private,         default: true

      t.timestamps
    end
  end
end
