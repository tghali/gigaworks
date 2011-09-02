class ClientContact < ActiveRecord::Base
	
 after_update :update_gigauser
 after_destroy :delete_gigauser
 
	  acts_as_paranoid 
  
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

	def update_gigauser
		user = Gigauser.find_by_client_contact_id(self.id)
		user.update_attribute(:role,self.role) if !user.blank?	
	end
	
	def delete_gigauser
		guser = Gigauser.find_by_client_contact_id(self.id)
		guser.destroy if !guser.blank?
	end



end
