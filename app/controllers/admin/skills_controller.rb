class Admin::SkillsController < Admin::AdminController
	
	
		def index
		@skills = Skill.find(:all)
		 respond_to do |format|	
		  format.html # new.html.erb
		  format.xml  { render :xml => @skills }
		end

	end
		
	def show
	end
	
	def new
		 @skill = Skill.new
		 respond_to do |format|
		   format.js
		   format.html
		   format.xml  { render :xml => @skill }
		end
	end
	
	def create
		@skill = Skill.new(params[:skill])    
		    authorize! :create, Skill      
		    @skill.author_id = current_user.id
		    respond_to do |format|
		      if @skill.save
			format.html { redirect_to(admin_skills_path, :notice => 'New Skill was successfully created.') }
			format.xml  { render :xml => @skill, :status => :created, :location => @skill }
		      else
			format.html { render :action => "new" }
			format.xml  { render :xml => @skill.errors, :status => :unprocessable_entity }
		      end
		    end
	end
	
	def edit
		@skill = Skill.find(params[:id])
		respond_to do |format|
		  format.js
		  format.html # new.html.erb 
		end		
	end
	
	def update
	   @skill = Skill.find(params[:id])	    
	    authorize! :update, @skill	    
	    respond_to do |format|
	      if @skill.update_attributes(params[:skill].merge :author => current_user)
		 format.html { redirect_to(admin_skills_path, :notice => 'Skill has been successfully updated.') } 
		 format.xml  { render :xml => @skill, :status => :created, :location => @skill }
	      else   
		format.html { render :action => "edit" }
		format.xml  { render :xml => @skill.errors, :status => :unprocessable_entity }
	      end
    end		
		
		
		
	end
	
	def destroy
		 @skill = Skill.find(params[:id])    
		  authorize! :destroy, @skill    
		
		
		  @destroyed = @skill.destroy
		    respond_to do |format|
		      format.html { redirect_to admin_skills_path, :notice => 'Skill was successfully deleted.' }
		      format.xml  { head :ok }
		end
	end
	
end
