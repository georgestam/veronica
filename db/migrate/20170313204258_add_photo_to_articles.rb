class AddPhotoToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :photo, :string
  end
end
