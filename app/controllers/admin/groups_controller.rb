class Admin::GroupsController < Admin::AdminController
	
	def index
		@groups = Group.find(:all,:conditions =>  "parent_id == 0")
		 respond_to do |format|	
		  format.html # new.html.erb
		  format.xml  { render :xml => @groups }
		end

	end
		
	def show
	end
	
	def new
		 @group = Group.new
		 respond_to do |format|
		   format.js
		   format.html
		   format.xml  { render :xml => @group }
		end
	end
	
	def create
		@group = Group.new(params[:group])    
		    authorize! :create, Group      
		    @group.author_id = current_user.id
		    respond_to do |format|
		      if @group.save
			format.html { redirect_to(admin_groups_path, :notice => 'Group was successfully created.') }
			format.xml  { render :xml => @group, :status => :created, :location => @group }
		      else
			format.html { render :action => "new" }
			format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
		      end
		    end
	end
	
	def edit
		@group = Group.find(params[:id])
		respond_to do |format|
		  format.js
		  format.html # new.html.erb 
		end		
	end
	
	def update
	   @group = Group.find(params[:id])	    
	    authorize! :update, @group	    
	    respond_to do |format|
	      if @group.update_attributes(params[:group].merge :author => current_user)
		 format.html { redirect_to(admin_groups_url, :notice => 'Group has been successfully updated.') } 
		 format.xml  { render :xml => @group, :status => :created, :location => @group }
	      else   
		format.html { render :action => "edit" }
		format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
	      end
    end		
		
		
		
	end
	
	def destroy
		 @group = Group.find(params[:id])    
		  authorize! :destroy, @group    
		 Group.where(:parent_id =>@group.id).delete_all
		
		  @destroyed = @group.destroy
		    respond_to do |format|
		      format.html { redirect_to admin_groups_url, :notice => 'Group was successfully deleted.' }
		      format.xml  { head :ok }
		end
	end
	
	def users		
		@users = User.find(:all,:conditions => "group_id = #{params[:group_id]}")
	end

end
