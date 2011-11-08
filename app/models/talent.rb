class Talent < ActiveRecord::Base
 has_many   :languages
 
 
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
    guser.username = self.username
    guser.password = self.password
    guser.password_confirmation = self.password_confirmation
    guser.first_name = self.first_name
    guser.last_name = self.last_name
    guser.gigaclient_id = self.id
    guser.role = "Talent"
    guser.email = self.email
    guser.save!
		 #~ Gigauser.create(:first_name =>self.first_name , :last_name =>self.last_name , :gigaclient_id => self.id, :role_id => 5,:email =>self.email )
end     
    
end
