class GigavineDepartment < ActiveRecord::Base
	belongs_to    :author,     :class_name => 'User'
	
	validates_presence_of :department_id, :name, :description
	validates_uniqueness_of :department_id
	
end
