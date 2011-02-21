class Organisation < ActiveRecord::Base
  
  has_many :contacts
  
  has_one :account
  
  validates_uniqueness_of :name
  validates_format_of :country_code, :with => /^(\w+)$/ #TODO: validate against a list
  
end
