class Schedule::AdminController < ApplicationController
   layout 'admin/gigaclient'
	 before_filter :authenticate	 
  def index
    	sort = params[:sort]
		if sort 
			if sort == 'email_d'
				sort = 'email DESC'
			elsif sort ==  'email_a'
				sort = 'email ASC'
			elsif sort ==  'fname_d'
				sort = 'first_name DESC'
			elsif sort ==  'fname_a'
				sort = 'first_name ASC'
			elsif sort ==  'lname_d'
				sort = 'last_name DESC'
			elsif sort ==  'lname_a'
				sort = 'last_name ASC'
			elsif sort ==  'role_d'
				sort = 'role DESC'
			elsif sort ==  'role_a'
				sort = 'role ASC'
			elsif sort ==  'org_d'
				sort = 'organization DESC'
			elsif sort ==  'org_a'
				sort = 'organization ASC'
			else
				sort = "created_at DESC"
			end
			end

	  @client_contacts = ClientContact.where(:gigaclient_id => current_user.id).order(sort)
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

  def edit_contact
	  @client_contact = ClientContact.find(params[:id])
    respond_to do |format|
      format.html # edit.html.erb
      format.xml  { render :xml => @client_contact }
    end
 end
  
  def update_contact
   @client_contact = ClientContact.find(params[:id])
    respond_to do |format|
	    	   if @client_contact.update_attributes(params[:client_contact])
			format.html {redirect_to users_list_path,:notice => "Contact details was successfully updated." }
			format.xml  { render :xml => @client_contact }
		else
		format.html { render :action => "edit_contact"}
		format.xml  { render :xml => @client_contact.errors, :status => :unprocessable_entity }
		end
    end
  end
  
  
  def contact_delete
	  contact = ClientContact.find(params[:id])	 
	  if contact

		  contact.destroy

		  
		     respond_to do |format|
		
		      format.html {redirect_to users_list_path,:notice => "Contact was successfully deleted" } # new.html.erb
		      format.xml  { render :xml => contact }
		    end	
	else
		     respond_to do |format|	
		      format.html {redirect_to users_list_path,:notice => "Contact was not found to delete" } # new.html.erb
		      format.xml  { render :xml => contact }
		    end				
	  end        
  end









end
