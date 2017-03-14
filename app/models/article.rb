class Article < ApplicationRecord
     
  extend FriendlyId
  
  LANGUAGES = ['es', 'en']
  
  validates :title, presence: true, length: { minimum: 10 }
  validates :description, presence: true, length: { minimum: 50 }
  validates :locale, inclusion: { in: LANGUAGES }
  
  friendly_id :title, use: :slugged
                                  
  mount_uploader :photo, PhotoUploader

end
