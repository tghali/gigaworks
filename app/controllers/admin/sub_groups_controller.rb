class Admin::SubGroupsController < Admin::AdminController#ApplicationController
	
	def index
		@group = Group.find(params[:group])
		@sub_groups = Group.find(:all,:conditions => "parent_id = #{params[:group]}")
		 respond_to do |format|	
		  format.html # new.html.erb
		  format.xml  { render :xml => @sub_groups }
		end
	end
		
	def show
	end
	
	def new
		@find_group = Group.find(params[:group])
		 @group = Group.new
		 respond_to do |format|
		   format.js
		   format.html
		   format.xml  { render :xml => @group }
		end
	end
	
	def create
		@find_group = Group.find(params[:group_id])
		@group = Group.new(params[:group])    
		    authorize! :create, Group      
		    @group.author_id = current_user.id		    
		    respond_to do |format|
		      if @group.save
			format.html { redirect_to(admin_sub_groups_path(:group => @find_group.id), :notice => 'Subgroup was successfully created.') }
			format.xml  { render :xml => @group, :status => :created, :location => @group }
		      else
			format.html { render :action => "new" }
			format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
		      end
		    end
	end
	
	
	def edit
		@find_group = Group.find(params[:group])
		@group = Group.find(params[:id])
		respond_to do |format|
		  format.js
		  format.html # new.html.erb 
		end		
	end
	
	def update
	   @find_group = Group.find(params[:group_id])
	   @group = Group.find(params[:id])	    
	    authorize! :update, @group	    
	    respond_to do |format|
	      if @group.update_attributes(params[:group].merge :author => current_user)
		 format.html { redirect_to(admin_sub_groups_url(:group => @find_group.id), :notice => 'Subgroup has been successfully updated.') } 
		 format.xml  { render :xml => @group, :status => :created, :location => @group }
	      else   
		format.html { render :action => "edit" }
		format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
	      end
    end
		
	end
	
	def destroy
		@find_group = Group.find(params[:group])
		 @group = Group.find(params[:id])    
		  authorize! :destroy, @group    
		  @destroyed = @group.destroy
		    respond_to do |format|
		      format.html { redirect_to admin_sub_groups_url(:group => @find_group.id), :notice => 'Subgroup was successfully deleted.' }
		      format.xml  { head :ok }
		end
	end
	
	
	
end
