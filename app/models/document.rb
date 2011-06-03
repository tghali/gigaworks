class Document < ActiveRecord::Base
  belongs_to    :author,     :class_name => 'User'
  belongs_to :source_document
  validates_presence_of  :first_name, :last_name #,:name
  validates_attachment_presence :document
  #~ validates_file_format_of :document, :in => ["pdf", "doc", "xls","txt"], :message => "Invalid file format"
  
  validates_attachment_content_type :document, :content_type => [ 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
  'application/msword', 
  'application/pdf', 'application/octet-stream','image/jpeg','image/png', 
  'text/plain' ,'application/vnd.oasis.opendocument.spreadsheet', 'application/vnd.ms-excel', 'application/x-download']
   
   
     has_attached_file :document,
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
    :s3_permissions => "public-read",
     :path =>  "/assignments/:id/:filename" ,
    :bucket => 'Mawhiba' 
   
end
