class Admin::ClientsController < Admin::AdminController
	layout 'admin/new_admin'
	def index
		
		sort = params[:sort]
		if sort 
			if sort == 'name_d'
				sort = 'first_name DESC'
			elsif sort ==  'name_a'
				sort = 'first_name ASC'
			elsif sort ==  'project_d'
				sort = 'pms_url DESC'
			elsif sort ==  'project_a'
				sort = 'pms_url ASC'
			elsif sort ==  'pmanager_a'
				sort = 'project_manager_id ASC'
			elsif sort ==  'pmanager_d'
				sort = 'project_manager_id DESC'

			elsif sort ==  'email_a'
				sort = 'email ASC'
			elsif sort ==  'email_d'
				sort = 'email DESC'	
			elsif sort ==  'company_a'
				sort = 'company ASC'
			elsif sort ==  'company_d'
				sort = 'company DESC'
		    	else
				sort = 'created_at DESC'

			end
		end
		
	  if params[:search]
		@clients = Gigaclient.find(:all,:conditions => ["first_name LIKE ? OR home_country lIKE ? OR last_name lIKE ?","%#{params[:search]}%","#{params[:search]}%","%#{params[:search]}"]).paginate :page => params[:page],:per_page => 2 
	  else
		@clients = Gigaclient.find(:all,:order => sort)#.paginate :page => params[:page],:per_page => 2
	  end

		 respond_to do |format|	
		  format.html # new.html.erb
		  format.xml  { render :xml => @clients }
		end
	end
		
	def show
		if params[:method] == 'delete'
			 @gigaclient = Gigaclient.find(params[:id])    
			  authorize! :destroy, @gigaclient
			
			  @destroyed = @gigaclient.destroy
			    respond_to do |format|
			      format.html { redirect_to admin_clients_url, :notice => 'Client was successfully deleted.' }
			      format.xml  { head :ok }
			end
		
		else
		@client = Gigaclient.find(params[:id])
		 respond_to do |format|	
		  format.js # new.html.erb
		  format.xml  { render :xml => @client }
		end
	  end
	end
	
	def new
		 @gigaclient = Gigaclient.new
		 @gigaclient.client_addresses.build
		 @gigaclient.build_gigadomain
		 respond_to do |format|
		   format.html
		   format.xml  { render :xml => @gigaclient }
		end
	end
	
	def create

		 #~ render :text=> "hai" and return

		@gigaclient = Gigaclient.new(params[:gigaclient])    
		    authorize! :create, Gigaclient      
		    @gigaclient.author_id = current_user.id
		    
		    respond_to do |format|
		      if @gigaclient.save
			      @gigaclient.gigadomain.update_attribute(:gigaclient_id,  @gigaclient.id)
			      
			     @invite = @gigaclient.build_invite(:sender => current_user)
			     @invite.event_id = @gigaclient.id
			      @invite.event_type = 'Gigaclient'
			      if @invite.save
			      UserMailer.client_invite(@invite).deliver
                              @invite.update_attribute :sent_at, Time.now
			      end
			      
			      
			format.html { redirect_to(admin_clients_path, :notice => 'Client was successfully created.') }
			format.xml  { render :xml => @gigaclient, :status => :created, :location => @client }
		      else
			format.html { render :action => "new" }
			format.xml  { render :xml => @gigaclient.errors, :status => :unprocessable_entity }
		      end
		    end
	end
	
	def edit
		@gigaclient = Gigaclient.find(params[:id])
		if @gigaclient.gigadomain.blank?
			@gigaclient.build_gigadomain
		end
		if @gigaclient.client_addresses.blank?
			@gigaclient.client_addresses.build
		end		
		
		respond_to do |format|
		  format.html # new.html.erb 
		end		
	end
	
	def update	
	   @gigaclient = Gigaclient.find(params[:id])	    
	    authorize! :update, @gigaclient	    
	    respond_to do |format|
	      if @gigaclient.update_attributes(params[:gigaclient])
		 format.html { redirect_to(admin_clients_url, :notice => 'Client has been successfully updated.') } 
		 format.xml  { render :xml => @gigaclient, :status => :created, :location => @gigaclient }
	      else   

		format.html { render :action => "edit" }
		format.xml  { render :xml => @gigaclient.errors, :status => :unprocessable_entity }
	      end
    end		
		
		
		
	end
	
	def destroy
		render :text => "hi" and return
		 @gigaclient = Gigaclient.find(params[:id])    
		  authorize! :destroy, @gigaclient
		
		  @destroyed = @gigaclient.destroy
		    respond_to do |format|
		      format.html { redirect_to admin_clients_url, :notice => 'Client was successfully deleted.' }
		      format.xml  { head :ok }
		end
	end
	

	
	
end
