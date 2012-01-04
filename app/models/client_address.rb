class ClientAddress < ActiveRecord::Base
	belongs_to :gigaclient,     :class_name => "Gigaclient", :foreign_key => :gigaclient_id
end
