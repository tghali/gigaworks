class Schedule::ManageImagesController < ApplicationController
   layout 'admin/gigaclient'
   before_filter :authenticate	 		 
  def index

	  #~ @client_contacts = ClientContact.where(:gigaclient_id => current_user.id)
	  #~ authorize! :index, ClientContact
	  
  end
  
end
