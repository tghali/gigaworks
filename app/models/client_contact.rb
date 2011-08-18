class ClientContact < ActiveRecord::Base
	  has_one    :client_contact_invite, :foreign_key => 'recipient_id', :dependent => :destroy
end
