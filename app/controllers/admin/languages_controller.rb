class Admin::LanguagesController < Admin::AdminController
	
	
		def index
		@languages = Language.find(:all)
		 respond_to do |format|	
		  format.html # new.html.erb
		  format.xml  { render :xml => @language }
		end

	end
		
	def show
	end
	
	def new
		 @language = Language.new
		 respond_to do |format|
		   format.js
		   format.html
		   format.xml  { render :xml => @language }
		end
	end
	
	def create
		@language = Language.new(params[:language])    
		    authorize! :create, Language      
		    @language.author_id = current_user.id
		    respond_to do |format|
		      if @language.save
			format.html { redirect_to(admin_languages_path, :notice => 'Language was successfully created.') }
			format.xml  { render :xml => @language, :status => :created, :location => @language }
		      else
			format.html { render :action => "new" }
			format.xml  { render :xml => @language.errors, :status => :unprocessable_entity }
		      end
		    end
	end
	
	def edit
		@language = Language.find(params[:id])
		respond_to do |format|
		  format.js
		  format.html # new.html.erb 
		end		
	end
	
	def update
	   @language = Language.find(params[:id])	    
	    authorize! :update, @language	    
	    respond_to do |format|
	      if @language.update_attributes(params[:language].merge :author => current_user)
		 format.html { redirect_to(admin_languages_path, :notice => 'Language has been successfully updated.') } 
		 format.xml  { render :xml => @language, :status => :created, :location => @language }
	      else   
		format.html { render :action => "edit" }
		format.xml  { render :xml => @language.errors, :status => :unprocessable_entity }
	      end
    end		
		
		
		
	end
	
	def destroy
		 @language = Language.find(params[:id])    
		  authorize! :destroy, @language    
		
		
		  @destroyed = @language.destroy
		    respond_to do |format|
		      format.html { redirect_to admin_languages_path, :notice => 'Language was successfully deleted.' }
		      format.xml  { head :ok }
		end
	end
	

	
end
