class Admin::ClientsController < Admin::AdminController
	
	def index
	  if params[:search]
		@clients = Gigaclient.find(:all,:conditions => ["first_name LIKE ? OR home_country lIKE ? OR last_name lIKE ?","%#{params[:search]}%","#{params[:search]}%","%#{params[:search]}"]).paginate :page => params[:page],:per_page => 2 
	  else
		@clients = Gigaclient.find(:all).paginate :page => params[:page],:per_page => 2
	  end

		 respond_to do |format|	
		  format.html # new.html.erb
		  format.xml  { render :xml => @clients }
		end
	end
		
	def show
		@client = Gigaclient.find(params[:id])
		 respond_to do |format|	
		  format.js # new.html.erb
		  format.xml  { render :xml => @client }
		end
	end
	
	def new
		 @gigaclient = Gigaclient.new
		 @gigaclient.client_addresses.build
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
		#~ @gigaclient.client_addresses.build
		respond_to do |format|
		  format.html # new.html.erb 
		end		
	end
	
	def update
#~ render :text => params.inspect and return		
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
		 @gigaclient = Gigaclient.find(params[:id])    
		  authorize! :destroy, @gigaclient
		
		  @destroyed = @gigaclient.destroy
		    respond_to do |format|
		      format.html { redirect_to admin_clients_url, :notice => 'Client was successfully deleted.' }
		      format.xml  { head :ok }
		end
	end
	
	
end
