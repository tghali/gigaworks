class Talent < ActiveRecord::Base
 has_many   :languages
 
 
   has_attached_file :resume_file_name,
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
    :s3_permissions => "public-read", 

    :path =>  "/resume/:id/:style.:extension" ,
    :bucket => 'sharmanyros'    
end
