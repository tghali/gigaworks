class Gigaclient < ActiveRecord::Base
	
	belongs_to    :author,     :class_name => 'User'
	
		 has_one :gigadomain,:dependent => :destroy
     accepts_nested_attributes_for :gigadomain, :allow_destroy => true
         
	  has_many   :client_addresses
	  accepts_nested_attributes_for :client_addresses, :allow_destroy => true
	
	validates_presence_of :first_name, :last_name
	validates_presence_of :email 
	#~ validates_presence_of :pms_url	
	
	validates_uniqueness_of :first_name,:last_name
	validates_format_of :email, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i
	#validates_format_of :web_page, :with => /^[a-zA-Z]+[:\/\/]+[A-Za-z0-9\-_]+\\.+[A-Za-z0-9\.\/%&=\?\-_]+$/i

 #validates_numericality_of :mobile_phone, :if => :mobile_phone? 
	
 after_save :gigausers
	
	
	def gigausers
		 Gigauser.create(:first_name =>self.first_name , :last_name =>self.last_name , :gigaclient_id => self.id, :role_id => 5,:email =>self.email )
	end
	
	
	
end
