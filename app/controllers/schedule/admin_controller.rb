class Schedule::AdminController < ApplicationController
   layout 'admin/gigaclient'
		 
  def index
	  @client_contacts = ClientContact.all
  end
  
  def new
     @client_contact = ClientContact.new
     respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @client_contact }
    end
  end
  
  def create
    @client_contact = ClientContact.new(params[:client_contact])
    @client_contact.gigaclient_id = current_user.id
    #~ authorize! :create_contact, Contact
    respond_to do |format|
	      if @client_contact.save
		format.html {redirect_to users_list_url, :notice => 'Contact was successfully created.' }
		format.xml  { render :xml => @client_contact, :status => :created, :location => @client_contact }
	      else
		format.html { render :action => "new"}
		format.xml  { render :xml => @client_contact.errors, :status => :unprocessable_entity }
	      end
    end
  end
  
  def user_invitation
	@client_contact = ClientContact.find(params[:id])
	@invite = @client_contact.build_client_contact_invite(:sender => current_user)
	if @invite.save
	UserMailer.client_contact_invite(@invite).deliver
        @invite.update_attribute :sent_at, Time.now
	flash[:notice] = "Contact was successfully invited."
	redirect_to users_list_path
	end
  end 
  
  
  
end
