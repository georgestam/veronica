class ApplicationRecord < ActiveRecord::Base
  
  include ApplicationRecordImpl
  
  self.abstract_class = true
end
