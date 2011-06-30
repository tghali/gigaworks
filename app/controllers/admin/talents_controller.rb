class Admin::TalentsController < Admin::AdminController
		
	
		def index
	  if params[:search]
		@talents = Talent.find(:all,:conditions => ["first_name LIKE ?  OR last_name lIKE ?","%#{params[:search]}%","#{params[:search]}%"]).paginate :page => params[:page],:per_page => 2 
	  else
		@talents = Talent.find(:all).paginate :page => params[:page],:per_page => 2
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
		@languages = Language.find(:all)
		@skills = Skill.find(:all)
		 @talent = Talent.new
		 respond_to do |format|
		   format.html
		   format.xml  { render :xml => @talent }
		end
	end
	
	def create
		#~ render :text=> params.inspect and return
		@talent = Talent.new(params[:talent])    
		    #~ authorize! :create, Talent      
		    #~ @talent.author_id = current_user.id
		    respond_to do |format|
		      if @talent.save
			format.html { redirect_to(admin_talents_path, :notice => 'Talent was successfully created.') }
			format.xml  { render :xml => @talent, :status => :created, :location => @talent }
		      else
			format.html { render :action => "new" }
			format.xml  { render :xml => @talent.errors, :status => :unprocessable_entity }
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
