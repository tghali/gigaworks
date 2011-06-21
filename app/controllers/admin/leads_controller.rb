class Admin::LeadsController < Admin::AdminController
	
	def index
	  if params[:search]
		@leads = ContactInformation.find(:all,:conditions => ["(contacts.first_name LIKE ? OR home_country lIKE ? OR contacts.last_name lIKE ?) AND contacts.group_id = 1","%#{params[:search]}%","#{params[:search]}%","%#{params[:search]}"],:include => :contact).paginate :page => params[:page],:per_page => 2
	  else
		@leads = ContactInformation.find(:all,:conditions => ["contacts.group_id = 1"],:include => :contact).paginate :page => params[:page],:per_page => 2
	  end

		 respond_to do |format|	
		  format.html # new.html.erb
		  format.xml  { render :xml => @leads }
		end
	end
		
	def show
		@lead = ContactInformation.find(params[:id])
		 respond_to do |format|	
		  format.js # new.html.erb
		  format.xml  { render :xml => @lead }
		end
	end
	
	def new
		     @groups = Group.find(:all)
		     @contact = Contact.new
		     @contact.build_contact_information
		 respond_to do |format|
		   format.html
		   format.xml  { render :xml => @contact }
		end
	end
	
	def create	
	
		@contact = Contact.new(params[:contact]) 
		@contact.group_id = 1	
		@contact.build_contact_information(params[:contact][:contact_information_attributes])

		    authorize! :create, Contact    

		    respond_to do |format|
		      if @contact.save
			format.html { redirect_to(admin_leads_path, :notice => 'Lead was successfully created.') }
			format.xml  { render :xml => @contact, :status => :created, :location => @contact }
		      else
			@groups = Group.find(:all)      
			format.html { render :action => "new" }
			format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
		      end
		    end
	end
	
	def edit
		lead = ContactInformation.find(params[:id])
		@contact = Contact.find(lead.contact_id)
		respond_to do |format|
		  format.html # new.html.erb 
		end		
	end
	
	def update	  
	  @contact = Contact.find(params[:id])  
	    authorize! :update, @contact	    
	    respond_to do |format|
	      if @contact.update_attributes(params[:contact]) && @contact.contact_information.update_attributes(params[:contact][:contact_information_attributes])  
			 

				format.html { redirect_to(admin_leads_url, :notice => 'Lead has been successfully updated.') } 
				 format.xml  { render :xml => @contact, :status => :created, :location => @contact }
			      else   
				format.html { render :action => "edit" }
				format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
			end

    end		
		
		
		
	end
	
	def destroy
		 lead = ContactInformation.find(params[:id])
		 @contact = Contact.find(lead.contact_id)    
		  authorize! :destroy, @contact
		
		  @destroyed = @contact.destroy
		    respond_to do |format|
		      format.html { redirect_to admin_leads_url, :notice => 'Lead was successfully deleted.' }
		      format.xml  { head :ok }
		end
	end
	
	
end
