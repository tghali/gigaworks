class Prospect < ActiveRecord::Base
	
	attr_accessor :move_to,:prospect_id
	validates_presence_of :name,:email,:phone,:subject,:country
	validates_format_of :email, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i, :if => Proc.new { |u| !u.email.blank? }
	validates_format_of :phone,  :with => /^[\(\)0-9\- \+\.]{10,20}$/ , :if => Proc.new { |u| !u.phone.blank? }
end
