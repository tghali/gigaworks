class Talent < ActiveRecord::Base
 has_many   :languages
 attr_accessor :password,:username, :password_confirmation
 
   has_attached_file :resume_file_name,
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
    :s3_permissions => "public-read", 

    :path =>  "/resume/:id/:style.:extension" ,
    :bucket => 'sharmanyros' 
      after_save :gigausers
	
	#validates_numericality_of :mobile_phone, :if => :mobile_phone? 
    def gigausers
    
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
    guser.username=self.first_name[0,1] + self.last_name
    if Gigauser.find_by_username(guser.username)
       guser.username=self.first_name + self.last_name
       if Gigauser.find_by_username(guser.username)
          guser.username = self.first_name + "." + self.last_name
       end
    end
  end
      # from talents registration
    if self.password
    guser.password = self.password
       #from network registration
    else
     guser.password = '12345678'
    end
    if self.password_confirmation
    guser.password_confirmation = self.password_confirmation
    else
     guser.password_confirmation = '12345678'
    end
    #guser.password_confirmation = self.password_confirmation
    guser.first_name = self.first_name
    guser.last_name = self.last_name
    guser.gigaclient_id = self.id
    guser.role = "Talent"
    guser.email = self.email
    guser.save!
		 #~ Gigauser.create(:first_name =>self.first_name , :last_name =>self.last_name , :gigaclient_id => self.id, :role_id => 5,:email =>self.email )
end     

    
end
