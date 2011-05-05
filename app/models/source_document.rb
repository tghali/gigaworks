class SourceDocument < ActiveRecord::Base
  has_many :documents,:dependent => :delete_all
  
  validates_presence_of :name
end
