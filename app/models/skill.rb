class Skill < ActiveRecord::Base
	
	 belongs_to    :author,     :class_name => 'User'
	 
	 validates_presence_of :name,:title
	 validates_uniqueness_of :name

end
