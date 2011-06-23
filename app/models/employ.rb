class Employ < ActiveRecord::Base
	
	 belongs_to :department, :class_name => "GigavineDepartment"
	 belongs_to    :author,     :class_name => 'User'
	 validates_presence_of :first_name,:last_name,:email,:date_of_join
	 validates_uniqueness_of :email
	
	  validates_attachment_content_type :passport, :content_type =>  /^image\//,:message => "should be image"
	
  has_attached_file :passport,
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
    :s3_permissions => "public-read", 

    :path =>  "/passport/:id/:style.:extension" ,
    :bucket => 'sharmanyros'     
	
	
end
