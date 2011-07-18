class BriefDetail < ActiveRecord::Base
	
	  has_attached_file :attachment,
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
    :s3_permissions => "public-read", 

    :path =>  "/brief_details/:id/:style.:extension" ,
    :bucket => 'sharmanyros'   
	
	
end
