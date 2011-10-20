class BriefDetail < ActiveRecord::Base
	
	  has_attached_file :attachment,
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
    :s3_permissions => "public-read", 
  #~ :path =>  lambda { |briefdetail| "/brief_details/#{briefdetail.name}/:id/:style:extension" },
    :path =>  "/brief_details/technology/:id/:style.:extension" ,
    :bucket => 'Mawhiba'   
	
	
end
