class Admin::LeadsController < Admin::AdminController
	
	def index
	    sort = case params['sort']
		 when "first_name"  then "first_name"  
		  when "email"  then "email" 
		   when "appointed_to"  then "appointed_to" 

		 when "first_name_reverse"  then "first_name DESC"
		 when "email_reverse"  then "email  DESC"  
		 when "appointed_to_reverse"  then "appointed_to DESC"
	
       end	
		condition = nil
	        if params[:industry_search] && params[:industry_search] != 'Select Industry' 
			condition  = "industry LIKE \"%#{params[:industry_search]}%\""
		end
	    
		 if params[:turnover_search] && params[:turnover_search] != 'Select Turnover'
			 if !condition.blank?
				condition  = condition + "AND turnover LIKE \"#{params[:turnover_search]}\""
			else
				condition  = "turnover LIKE \"#{params[:turnover_search]}\""
			end
		end
		
	  if condition != nil
	  
		@leads = Lead.find(:all,:conditions => condition).paginate :page => params[:page],:per_page => 4,:order => sort
	  else

		@leads = Lead.find(:all).paginate :page => params[:page],:per_page => 4,:order => sort
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
