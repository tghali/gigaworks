class Supplier < ActiveRecord::Base
	
		belongs_to    :author,     :class_name => 'User'
		validates_presence_of :title, :name, :company,:industry,:mobile
	
	
	
end
