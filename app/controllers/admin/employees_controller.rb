class Admin::EmployeesController < Admin::AdminController
	
	def index
	  if params[:search]
		@employees = ContactInformation.find(:all,:conditions => ["(contacts.first_name LIKE ? OR home_country lIKE ? OR contacts.last_name lIKE ?)  AND contacts.group_id = 2","%#{params[:search]}%","#{params[:search]}%","%#{params[:search]}"],:include => :contact).paginate :page => params[:page],:per_page => 2
	  else
		@employees= ContactInformation.find(:all,:conditions => ["contacts.group_id = 2"],:include => :contact).paginate :page => params[:page],:per_page => 2
	  end

		 respond_to do |format|	
		  format.html # new.html.erb
		  format.xml  { render :xml => @leads }
		end
	end
		
	def show
		@employ = ContactInformation.find(params[:id])
		 respond_to do |format|	
		  format.js # new.html.erb
		  format.xml  { render :xml => @employ }
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
		@contact.group_id = 2
		@contact.build_contact_information(params[:contact][:contact_information_attributes])
		
		    authorize! :create, Contact    

		    respond_to do |format|
		      if @contact.save
			format.html { redirect_to(admin_employees_path, :notice => 'Employee was successfully created.') }
			format.xml  { render :xml => @contact, :status => :created, :location => @contact }
		      else
			@groups = Group.find(:all)      
			format.html { render :action => "new" }
			format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
		      end
		    end
	end
	
	def edit
		emp = ContactInformation.find(params[:id])
		@contact = Contact.find(emp.contact_id)
		respond_to do |format|
		  format.html # new.html.erb 
		end		
	end
	
	def update			
	  @contact = Contact.find(params[:id])  
	    authorize! :update, @contact	    
	    respond_to do |format|
	      if @contact.update_attributes(params[:contact]) && @contact.contact_information.update_attributes(params[:contact][:contact_information_attributes])  
			 

				format.html { redirect_to(admin_employees_url, :notice => 'Employ has been successfully updated.') } 
				 format.xml  { render :xml => @contact, :status => :created, :location => @contact }
			      else   
				format.html { render :action => "edit" }
				format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
			end

    end		
		
		
		
	end
	
	def destroy
		 emp = ContactInformation.find(params[:id])
		 @contact = Contact.find(emp.contact_id)    
		  authorize! :destroy, @contact
		
		  @destroyed = @contact.destroy
		    respond_to do |format|
		      format.html { redirect_to admin_employees_url, :notice => 'Employ was successfully deleted.' }
		      format.xml  { head :ok }
		end
	end
	
	
	
end
