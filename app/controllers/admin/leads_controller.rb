class Admin::LeadsController < Admin::AdminController
	
	def index
	  if params[:search]
		@leads = Lead.find(:all,:conditions => ["(first_name LIKE ?  OR last_name lIKE ?)","%#{params[:search]}%","#{params[:search]}%"],:include => :lead).paginate :page => params[:page],:per_page => 4
	  else
		@leads = Lead.find(:all).paginate :page => params[:page],:per_page => 4
	  end

		 respond_to do |format|	
		  format.html # new.html.erb
		  format.xml  { render :xml => @leads }
		end
	end
		
	def show
	
		@lead = Lead.find(params[:id])
		 respond_to do |format|	
		  format.js # new.html.erb
		  format.xml  { render :xml => @lead }
		end
	end
	
	def new
		     @groups = Group.find(:all)
		     @lead = Lead.new
		     #@lead.build_contact_information
		 respond_to do |format|
		   format.html
		   format.xml  { render :xml => @lead }
		end
	end
	
	def create	
	
		@lead = Lead.new(params[:lead]) 

		    authorize! :create, Lead    

		    respond_to do |format|
		      if @lead.save
			format.html { redirect_to(admin_leads_path, :notice => 'Lead was successfully created.') }
			format.xml  { render :xml => @lead, :status => :created, :location => @lead }
		      else
			@groups = Group.find(:all)      
			format.html { render :action => "new" }
			format.xml  { render :xml => @lead.errors, :status => :unprocessable_entity }
		      end
		    end
	end
	
	def edit
		@lead = Lead.find(params[:id])
		#~ @contact = Contact.find(lead.contact_id)
		respond_to do |format|
		  format.html # new.html.erb 
		end		
	end
	
	def update	  
	  @lead = Lead.find(params[:id])  
	    authorize! :update, @lead	    
	    respond_to do |format|
	      if @lead.update_attributes(params[:lead])  
			 

				format.html { redirect_to(admin_leads_url, :notice => 'Lead has been successfully updated.') } 
				 format.xml  { render :xml => @lead, :status => :created, :location => @lead }
			      else   
				format.html { render :action => "edit" }
				format.xml  { render :xml => @lead.errors, :status => :unprocessable_entity }
			end

    end		
		
		
		
	end
	
	def destroy
		 @lead = Lead.find(params[:id])
		 #@lead = Contact.find(lead.contact_id)    
		  authorize! :destroy, @lead
		
		  @destroyed = @lead.destroy
		    respond_to do |format|
		      format.html { redirect_to admin_leads_url, :notice => 'Lead was successfully deleted.' }
		      format.xml  { head :ok }
		end
	end
	
	
end
