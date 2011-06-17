class Admin::ClientsController < Admin::AdminController
	
		def index
		@clients = Gigaclient.find(:all)
		 respond_to do |format|	
		  format.html # new.html.erb
		  format.xml  { render :xml => @clients }
		end

	end
		
	def show
	end
	
	def new
		 @gigaclient = Gigaclient.new
		 respond_to do |format|
		   format.html
		   format.xml  { render :xml => @gigaclient }
		end
	end
	
	def create
		@gigaclient = Gigaclient.new(params[:gigaclient])    
		    authorize! :create, Gigaclient      
		    #~ @group.author_id = current_user.id
		    respond_to do |format|
		      if @gigaclient.save
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
		respond_to do |format|
		  format.html # new.html.erb 
		end		
	end
	
	def update
	   @gigaclient = Gigaclient.find(params[:id])	    
	    authorize! :update, @gigaclient	    
	    respond_to do |format|
	      if @gigaclient.update_attributes(params[:gigaclient])
		 format.html { redirect_to(admin_groups_url, :notice => 'Client has been successfully updated.') } 
		 format.xml  { render :xml => @gigaclient, :status => :created, :location => @gigaclient }
	      else   
		format.html { render :action => "edit" }
		format.xml  { render :xml => @gigaclient.errors, :status => :unprocessable_entity }
	      end
    end		
		
		
		
	end
	
	def destroy
		 @gigaclient = Gigaclient.find(params[:id])    
		  authorize! :destroy, @gigaclient
		
		  @destroyed = @gigaclient.destroy
		    respond_to do |format|
		      format.html { redirect_to admin_clients_url, :notice => 'Client was successfully deleted.' }
		      format.xml  { head :ok }
		end
	end
	
	
end
