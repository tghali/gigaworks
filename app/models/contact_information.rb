class ContactInformation < ActiveRecord::Base
	belongs_to :contact
	
	attr_accessor :group_id
	
	validates_presence_of :business_street , :if => Proc.new {|e| e.group_id == '1'}
	validates_presence_of :qualification, :department, :if => Proc.new {|e| e.group_id == '2'}
end
