class ClientContact < ActiveRecord::Base
	  has_one :client_contact_invite, :foreign_key => 'recipient_id', :dependent => :destroy
	  
	 validates :first_name,
	    :presence => true,
	    :uniqueness => {:if => :first_name?}
	  
	  validates :last_name,:organization,:role,
	     :presence => true

	  validates :email,   
            :presence => true,   
	    :uniqueness => { :scope => :gigaclient_id },	
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i , :message => "is invalid format", :if => :email?}

end
