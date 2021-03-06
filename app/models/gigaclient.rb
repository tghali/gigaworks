class Gigaclient < ActiveRecord::Base
	
	belongs_to    :author,     :class_name => 'User'
	
		 has_one :gigadomain,:dependent => :destroy
     accepts_nested_attributes_for :gigadomain, :allow_destroy => true
         
	  has_many   :client_addresses
	  accepts_nested_attributes_for :client_addresses, :allow_destroy => true
	
  
  
  has_one  :invite,:foreign_key => 'event_id',:dependent => :destroy
  
  attr_accessor :password,:username, :password_confirmation
  
	validates_presence_of :first_name, :last_name
	validates_presence_of :email 
	#~ validates_presence_of :pms_url	
	
	#~ validates_uniqueness_of :first_name,:last_name
	validates_format_of :email, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i
	#validates_format_of :web_page, :with => /^[a-zA-Z]+[:\/\/]+[A-Za-z0-9\-_]+\\.+[A-Za-z0-9\.\/%&=\?\-_]+$/i

 #validates_numericality_of :mobile_phone, :if => :mobile_phone? 
	
      has_attached_file :logo,
    :storage => :s3,    
    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
    :s3_permissions => "public-read", 
    #~ :path =>  lambda { |doc| "/assignments/#{doc.name}/:id/:style:extension" },
    :path =>  "clients/logo/:id/:style.:extension" ,
    :styles => { :thumb => "100x100#", :large => "400x400#",:medium => "300x300#",:normal => "291x122#" },
    :bucket => 'Mawhiba' 
  
  
  
  
  
 after_save :gigausers
	
	
	#~ def gigausers
    #~ @gfind = Gigauser.find_by_sql("SELECT id FROM gigausers order by id DESC limit 1")
    #~ guser = Gigauser.new
    #~ guser.id = @gfind[0]['id'] + 1
    #~ guser.username = self.username
    #~ guser.password = self.password
    #~ guser.password_confirmation = self.password_confirmation    
    #~ guser.first_name = self.first_name
    #~ guser.last_name = self.last_name
    #~ guser.gigaclient_id = self.id
    #~ guser.role = "Client"
    #~ guser.email = self.email
    #~ guser.save
		# Gigauser.create(:first_name =>self.first_name , :last_name =>self.last_name , :gigaclient_id => self.id, :role_id => 5,:email =>self.email )
   #~ end
   
   
   def gigausers
    guser= Gigauser.first(:conditions => "gigaclient_id= #{self.id} and role='Client'")
    if !guser
    
    @gfind = Gigauser.find_by_sql("SELECT id FROM gigausers order by id DESC limit 1")
    guser = Gigauser.new
    guser.id = @gfind[0]['id'] + 1
    puts " hellllllooooooooooooo  #{guser.id}"
    # from talents registration
    if self.username
    guser.username = self.username
    #from network registration
    else
     puts "i got it...#{self.first_name[0,1]}"
    #guser.username=self.first_name[0,1] + self.last_name
    #if Gigauser.find_by_username(guser.username)
       #guser.username=self.first_name + self.last_name
       #if Gigauser.find_by_username(guser.username)
          #guser.username = self.first_name + "." + self.last_name
          guser.username = self.company
       #end
    #end
  end
      # from talents registration
    #if self.password
    guser.password = self.password
       #from network registration
    #else
     #guser.password = '12345678'
    #end
    #if self.password_confirmation
    guser.password_confirmation = self.password_confirmation
    #else
     #guser.password_confirmation = '12345678'
    #end
    #guser.password_confirmation = self.password_confirmation
    guser.first_name = self.first_name
    guser.last_name = self.last_name
    guser.gigaclient_id = self.id
    guser.role = "Client"
    guser.email = self.email
    guser.save!
   end
		 #~ Gigauser.create(:first_name =>self.first_name , :last_name =>self.last_name , :gigaclient_id => self.id, :role_id => 5,:email =>self.email )
end     
	
	
	
end
