class Admin::SuppliersController < Admin::AdminController
	
			def index
	  if params[:search]
		@suppliers = Supplier.find(:all,:conditions => ["name LIKE ? ","#{params[:search]}%"]).paginate :page => params[:page],:per_page => 2 
	  else
		@suppliers = Supplier.find(:all).paginate :page => params[:page],:per_page => 2
	  end

		 respond_to do |format|	
		  format.html # new.html.erb
		  format.xml  { render :xml => @suppliers }
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
		 @supplier = Supplier.new
		 respond_to do |format|
		   format.html
		   format.xml  { render :xml => @supplier }
		end
	end
	
	def create
	  #~ render :text=> params.inspect and return
		@supplier = Supplier.new(params[:supplier])    
		    authorize! :create, Supplier      
		    @supplier.author_id = current_user.id
		    respond_to do |format|
		      if @supplier.save
			format.html { redirect_to(admin_suppliers_path, :notice => 'Supplier was successfully created.') }
			format.xml  { render :xml => @supplier, :status => :created, :location => @supplier }
		      else
			format.html { render :action => "new" }
			format.xml  { render :xml => @supplier.errors, :status => :unprocessable_entity }
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
