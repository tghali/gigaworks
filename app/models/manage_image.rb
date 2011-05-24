class ManageImage < ActiveRecord::Base

	
	belongs_to :author, :class_name => "User"
	
  validates_presence_of :subject
  
  cattr_reader :per_page
  @@per_page =8
  
  validates_attachment_presence :image  
  validates_attachment_content_type :image, :content_type => ['image/jpeg','image/png','image/gif']
   
    #~ Paperclip.options[:swallow_stderr] = false 
    
    has_attached_file :image,
    :storage => :s3,    
    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
    :s3_permissions => "public-read", 
    #~ :path =>  lambda { |doc| "/assignments/#{doc.name}/:id/:style:extension" },
     :url =>  "/images/:id/:style.:extension" ,
     :styles => { :medium => "300x300>", :thumb => "100x100>", :original => "400x400>" },
    :bucket => 'Mawhiba' 
     
       named_scope :search, lambda { |str,cond_text,cond_values| {:conditions => ( [cond_text,*cond_values]),:order => "created_at DESC"}}
    named_scope :search_with_subject, 	lambda { |str| {:conditions => (["subject LIKE ?", "%#{str}%"])}}
 

	
	
	
	
end
