class Translation < ActiveRecord::Base
  belongs_to :definition
  belongs_to :word
  
  accepts_nested_attributes_for :word, :reject_if => proc { |obj| obj.blank? }
  
end
