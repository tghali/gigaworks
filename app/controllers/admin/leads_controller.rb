require 'fastercsv'
require 'csv'
require 'vpim/vcard'

class Admin::LeadsController < Admin::AdminController
	
	def index
		@appointed_count = Lead.count(:conditions => "appointed_to != '' ")
		 @all_leads = Lead.count
		sort = params[:sort]
		if sort 
			if sort == 'company_d'
				sort = 'company DESC'
			elsif sort ==  'company_a'
				sort = 'company ASC'
			elsif sort ==  'fname_d'
				sort = 'first_name DESC'
			elsif sort ==  'fname_a'
				sort = 'first_name ASC'
			elsif sort ==  'industry_a'
				sort = 'industry ASC'
			elsif sort ==  'industry_d'
				sort = 'industry DESC'

			elsif sort ==  'appoint_a'
				sort = 'appointed_to ASC'
			elsif sort ==  'appoint_d'
				sort = 'appointed_to DESC'

			end
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
		
		if params[:lead]
		if params[:lead][:country]
			 if !condition.blank?
				condition  = condition + "AND country LIKE \"#{params[:lead][:country]}\""
			else
				condition  = "country LIKE \"#{params[:lead][:country]}\""
			end
		end
	     end	
	
	    if params[:list] == 'appointed'
		    	if !condition.blank?
				condition  = condition + "AND appointed_to != ''"
			else
				condition  = "appointed_to != ''"
			end
             end		    
		
	
	  if condition != nil	  
		@leads = Lead.find(:all,:conditions => condition,:order => sort).paginate :page => params[:page],:per_page => 4
	  else
		@leads = Lead.find(:all,:order => sort).paginate :page => params[:page],:per_page => 4
	  end

		 respond_to do |format|	
		  format.html # new.html.erb
		  format.xml  { render :xml => @leads }
		end
	end



  def csv_import 	  
	  
	if request.post? and params[:impcsv][:csv_file_upload]
		
		if params[:impcsv][:csv_file_upload].content_type == 'text/x-vcard' 

			cards = Vpim::Vcard.decode(params[:impcsv][:csv_file_upload].open)
			
			cards.each do |card|
			first_name, last_name = card['N'].split(';')
			
			email = card['EMAIL', 'INTERNET']
			
			Lead.create(:first_name=> first_name, :last_name=>last_name, :email=>email)

			end
			
				flash.now[:message]="Data Imported Successfully"
			     redirect_to(:action=>'index') and return
			
			
		end	
		 if params[:impcsv][:csv_file_upload].content_type == 'text/csv' 
			     @impcsv=CSV::Reader.parse(params[:impcsv][:csv_file_upload])
			     n=0
			     @impcsv.each  do |row|
			     c=Lead.new
			     c.first_name=row[0]
			     c.last_name=row[1]
			     c.email=row[2]
			     if c.save
				n=n+1
				GC.start if n%50==0
			      end
			       
			     end
			     flash.now[:message]="CSV Import Successful,  #{n} new  records added to data base"
			     redirect_to(:action=>'index') and return
                end
     		else
				 respond_to do |format|
				      format.html { redirect_to admin_leads_url, :notice => 'There is problem to upload csv please try again.' }
				      format.xml  { head :ok }
			      end	
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
		  authorize! :destroy, @lead
		
		  @destroyed = @lead.destroy
		    respond_to do |format|
		      format.html { redirect_to admin_leads_url, :notice => 'Lead was successfully deleted.' }
		      format.xml  { head :ok }
		end
	end

	def appoint_to
		if !params[:leads].blank? && !params[:lead][:appointed_to].blank?
			leads = Lead.find(:all,:conditions => "id in (#{params[:leads]})")	
			for lead in leads
				@lead = Lead.find(lead.id)
				@lead.update_attributes!(:appointed_to => params[:lead][:appointed_to])
				
			end
			respond_to do |format|
			      format.html { redirect_to admin_leads_url, :notice => 'Leads was successfully updated.' }
			      format.xml  { head :ok }
		      end
		else
			respond_to do |format|
			      format.html { redirect_to admin_leads_url, :notice => 'There is a problem to update leads please try again.' }
			      format.xml  { head :ok }
		      end
		end
			
	end

	def edit_leads
		#~ render :text => params[:leads_list].gsub(/ /,',') and return
		if !params[:leads_list].blank?
			       error = '0'
				@arr = params[:leads_list].split(" ").map{|s| s.to_i}
				@arr.each do |lead|
					 @lead = Lead.find(lead)
					 @lead.update_attributes(params["lead_#{lead}"])						
						#@leads = Lead.find(:all,:conditions => "id in (#{params[:leads_list].gsub(/ /,',')})")
						#~ render :text => params[:leads_list].gsub(/ /,',') and return
						#~ error = '1'							
						#render 'edit_leads',:lead => params[:leads_list].gsub(/ /,',')
						#~ break
					#~ end
					
				 end	
				#~ if error == '0'
				 respond_to do |format|
				      format.html { redirect_to admin_leads_url, :notice => 'Leads was successfully updated.' }
				      format.xml  { head :ok }
			      end
			      #~ end
		else
				 respond_to do |format|
				      format.html { redirect_to admin_leads_url, :notice => 'There is problem to update leads please try again.' }
				      format.xml  { head :ok }
			        end			
		end
	end
	
	def delete_all	
		 if params[:result] == 'delete'
		     if !params[:lead].blank?	 
				Lead.delete_all("id in (#{params[:lead].join(',')})")		
				 respond_to do |format|
				      format.html { redirect_to admin_leads_url, :notice => 'Leads was successfully deleted.' }
				      format.xml  { head :ok }
			      end
		     else
				    respond_to do |format|
				      format.html { redirect_to admin_leads_url, :notice => 'No Lead was selected to delete.' }
				      format.xml  { head :ok }
			          end
		      end
		elsif params[:result] == 'modify'
			if !params[:lead].blank?	
				
				#~ render :text => params[:lead].inspect and return
				#~ params[:lead].each do |lead|
					#~ leads_"#{lead}" = Lead.find(lead)					
				#~ end
				
				
				
				@leads = Lead.find(:all,:conditions => "id in (#{params[:lead].join(',')})")
				render 'edit_leads'
			else
				 respond_to do |format|
				      format.html { redirect_to admin_leads_url, :notice => 'No Lead was selected to modify.' }
				      format.xml  { head :ok }
			      end
			end	

		elsif params[:result] == 'appoint'
			if !params[:lead].blank?	
				@leads = params[:lead].join(',')		
				render 'appoint_leads'

	
			else
				 respond_to do |format|
				      format.html { redirect_to admin_leads_url, :notice => 'No Lead was selected to appoint.' }
				      format.xml  { head :ok }
			      end
			end	
		elsif params[:result] == 'import'
			#~ render :text=> params.inspect and return
				render 'csv_import'
			end
		
	end
	
end
