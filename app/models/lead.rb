class Lead < ActiveRecord::Base
  
  #~ has_one_baked_in  :status, :names => [:acquired, :assigned, :password_reset, :deleted, :suspended, :banned],
                             #~ :groups => {:active =>     [:verified, :password_reset],
                                         #~ :visible =>    [:unverified, :verified, :password_reset, :suspended],
                                         #~ :inactive =>   [:deleted, :suspended, :banned],
                                         #~ :unverified => [:unverified]}
  
  belongs_to :organisation
  belongs_to :contact, :class_name => "Contact"
    
  #belongs_to :sales # the sales operator's profile
  
 # has_many :activities, :class_name => "SalesActivity"
  
  
  	validates_presence_of :first_name, :last_name
	validates_presence_of :email 
	
	#~ validates_uniqueness_of :first_name,:last_name
	validates_format_of :email, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i
	#validates_format_of :web_page, :with => /^[a-zA-Z]+[:\/\/]+[A-Za-z0-9\-_]+\\.+[A-Za-z0-9\.\/%&=\?\-_]+$/i
  
  
  
  
  
  
  
  
  
  
  
  # belongs_to :source # Make it polymorphic
  
  #TODO wirite a class method for the contact importer that creates new leads or marks the duplicates
  #     as such in the activity stream.
  def self.import(contact)
    
  end
  
end
