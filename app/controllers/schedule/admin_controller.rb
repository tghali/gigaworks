class Schedule::AdminController < ApplicationController
   layout 'admin/gigaclient'
	 before_filter :authenticate	 
  def index
	  @client_contacts = ClientContact.where(:gigaclient_id => current_user.id)
    authorize! :index, ClientContact
  end
  
  def new
    authorize! :new, ClientContact
     @client_contact = ClientContact.new
     respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @client_contact }
    end
  end
  
  def create
    authorize! :create, ClientContact
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
  authorize! :user_invitation, ClientContactInvite
	@client_contact = ClientContact.find(params[:id])
         if ClientContactInvite.find_by_recipient_id(@client_contact.id)
            flash[:notice] = "The Contact was already invited."
            redirect_to users_list_path	
          else	
                    @invite = @client_contact.build_client_contact_invite(:sender => current_user)
                    if @invite.save
                    UserMailer.client_contact_invite(@invite).deliver
                    @invite.update_attribute :sent_at, Time.now
                    flash[:notice] = "Contact was successfully invited."
                    redirect_to users_list_path
                  end  ### inner if end
          end ### outer if end
   end   #### method end
  
  def user_access
	  client_contact = ClientContact.find(params[:id])
	  if client_contact
		  if params[:user_access]
			  client_contact.update_attribute(:login_access, "block")
			flash[:notice] = "Contact was successfully blocked. He is unable to access the site"
			redirect_to users_list_path				  
		  else
			  client_contact.update_attribute(:login_access, "open")
			flash[:notice] = "Contact was successfully opened. Now he can access the site with his login details"
			redirect_to users_list_path	
		  end
  
	else
		flash[:notice] = "The contact was not found in our database. Please try with original contact"
		redirect_to users_list_path			  
	  end
  end
  
end
