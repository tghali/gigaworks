class SourceDocument < ActiveRecord::Base
  belongs_to    :author,     :class_name => 'User'
  has_many :documents,:dependent => :delete_all
  
  validates_presence_of :name
  validates_uniqueness_of :name,:scope => :author_id  
end
