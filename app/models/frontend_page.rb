class FrontendPage < ActiveRecord::Base 
  attr_accessor :tab_type	
  belongs_to :author, :class_name => "User"	
  has_attached_file :image,
    :storage => :s3,    
    :styles => {  :thumb => "100x100>",
    :preview => "400x400>"},    
    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
     :path =>  "/frontend/:id/:style.:extension" ,
    :bucket => 'Mawhiba'   
end

