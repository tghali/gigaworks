class GigavineDepartment < ActiveRecord::Base
	belongs_to    :author,     :class_name => 'User'
	
	validates_presence_of :name, :description #:department_id,
	#~ validates_uniqueness_of :department_id
	
end
