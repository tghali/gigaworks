class Group < ActiveRecord::Base
	 belongs_to    :author,     :class_name => 'User'
	 
	 validates_presence_of :name,:description
	 validates_uniqueness_of :name
end
