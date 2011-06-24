class Language < ActiveRecord::Base
	 belongs_to    :author,     :class_name => 'User'
	 
	 validates_presence_of :name,:acronym
	 validates_uniqueness_of :name
	 
	 
	 validates_format_of :name, :with => /^[-a-zA-Z ]+$/
	 
end
