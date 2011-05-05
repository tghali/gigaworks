class Document < ActiveRecord::Base
  has_one    :author,     :class_name => 'User'
  belongs_to :source_document
  validates_presence_of      :first_name, :last_name,:name 
  
  
   has_attached_file :document,:url => lambda { |attachment| "/mydocuments/:id/:style_:filename" }

   validates_attachment_content_type :document, :content_type => [ 'application/msword', 'application/pdf', 'application/octet-stream','image/jpeg','image/png', 'text/plain' ,'application/vnd.oasis.opendocument.spreadsheet', 'application/vnd.ms-excel', 'application/x-download']

end
