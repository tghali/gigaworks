class Admin::DepartmentsController < Admin::AdminController
	
	def index
		@departments = GigavineDepartment.find(:all)
		 respond_to do |format|	
		  format.html # new.html.erb
		  format.xml  { render :xml => @departments }
		end

	end
		
	def show
	end
	
	def new
		 @department = GigavineDepartment.new
		 respond_to do |format|
		   format.js
		   format.html
		   format.xml  { render :xml => @department }
		end
	end
	
	def create
		@department = GigavineDepartment.new(params[:gigavine_department])    
		    authorize! :create, Group      
		    @department.author_id = current_user.id
		    respond_to do |format|
		      if @department.save
			format.html { redirect_to(admin_departments_path, :notice => 'Deaprtment was successfully created.') }
			format.xml  { render :xml => @department, :status => :created, :location => @department }
		      else
			format.html { render :action => "new" }
			format.xml  { render :xml => @department.errors, :status => :unprocessable_entity }
		      end
		    end
	end
	
	def edit
		@department = GigavineDepartment.find(params[:id])
		respond_to do |format|
		  format.js
		  format.html # new.html.erb 
		end		
	end
	
	def update
	   @department = GigavineDepartment.find(params[:id])	    
	    authorize! :update, @department	    
	    respond_to do |format|
	      if @department.update_attributes(params[:gigavine_department].merge :author => current_user)
		 format.html { redirect_to(admin_departments_path, :notice => 'Department has been successfully updated.') } 
		 format.xml  { render :xml => @department, :status => :created, :location => @department }
	      else   
		format.html { render :action => "edit" }
		format.xml  { render :xml => @department.errors, :status => :unprocessable_entity }
	      end
    end		
		
		
		
	end
	
	def destroy
		 @department = GigavineDepartment.find(params[:id])    
		  authorize! :destroy, @department    
		 Group.where(:parent_id =>@department.id).delete_all
		
		  @destroyed = @department.destroy
		    respond_to do |format|
		      format.html { redirect_to admin_departments_path, :notice => 'Department was successfully deleted.' }
		      format.xml  { head :ok }
		end
	end
	
	def users		
		@users = User.find(:all,:conditions => "group_id = #{params[:group_id]}")
	end
	
end
