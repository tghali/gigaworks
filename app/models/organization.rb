class Organization < ActiveRecord::Base
  
  has_many :contacts
  
  validates_uniqueness_of :name
  # validates_format_of :country_code, :with => /[a-z][a-z]/ #TODO: validate against a list
  
end
