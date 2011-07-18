class Admin::ProspectsController < Admin::AdminController
	layout 'admin/new_admin'
	def index
		@prospects = Prospect.find(:all)
		 respond_to do |format|	
			  format.html # new.html.erb
			  format.xml  { render :xml => @prospects }
		end
	end
	
	def move_to
		
		@prospect = Prospect.find(params[:prospect_id])
		 if params[:move_to] == 'Lead'
				if Lead.create(:first_name =>@prospect.name,:email => @prospect.email,:lead_frontend => '1', :country => @prospect.country,
				:state => @prospect.state,:city => @prospect.city,:notes => @prospect.message,:phone => @prospect.phone)
				
					@prospect.delete
					@notice = "Prospect was successfully moved to #{params[:move_to]}."
				else
					@notice = "There is a problem to create lead. Please try again.."
				end
		 elsif params[:move_to] == 'Customer' || params[:move_to] == 'Marketing' || params[:move_to] == 'Sales'
			 @notice = "Implementing is in process..."
		 end
		respond_to do |format|	
			  format.html{ redirect_to(admin_prospects_path, :notice => @notice) }
			  format.xml   { render :xml => @prospect, :status => :created, :location => @prospect }
		end
	end
end
