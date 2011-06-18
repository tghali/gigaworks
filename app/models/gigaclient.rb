class Gigaclient < ActiveRecord::Base
	
	belongs_to    :author,     :class_name => 'User'
	
	validates_presence_of :first_name, :middle_name,:last_name
	validates_presence_of :email, :business_street,:business_city,:business_state,:business_postal_code,:business_country,:notes
	validates_presence_of :pms_url	
	
	validates_uniqueness_of :first_name,:last_name
	validates_format_of :email, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i
	validates_format_of :email2, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i, :if => :email2? 
	
	validates_numericality_of :mobile_phone, :if => :mobile_phone? 
	
	
	
end
