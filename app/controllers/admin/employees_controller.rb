require 'fastercsv'
require 'csv'
class Admin::EmployeesController < Admin::AdminController
	layout 'admin/new_admin'
	def index
		  if params[:search]
		@employees = Employ.find(:all,:conditions => ["(first_name LIKE ? OR last_name lIKE ?)","%#{params[:search]}%","#{params[:search]}%"]).paginate :page => params[:page],:per_page => 2
	  else
		@employees= Employ.find(:all).paginate :page => params[:page],:per_page => 2
	  end
		 respond_to do |format|	
		  format.html # new.html.erb
		  format.xml  { render :xml => @employees }
		end

	end


def dashboard
@graph = open_flash_chart_object(720,200,"/admin/employees/graph_code")

end



 



def graph_code
 
       title = Title.new("Contact list Monitor")
 
        
        @leads = 10 #Lead.count(:all)
        @clients = 20 #Gigaclient.count(:all)
        @employees = 30 #Employ.count(:all)
    pie = Pie.new
    pie.start_angle = 35
    pie.animate = true
    pie.colours = ["#d01f3c", "#356aa0", "#C79810"]
      pie.values  = [PieValue.new(@leads,'Leads'),PieValue.new(@clients,'Cients'), PieValue.new(@employees,'Employees')]
    
    chart = OpenFlashChart.new
    chart.title = title
    chart.add_element(pie)

    chart.x_axis = nil

    render :text => chart.to_s
 
end

 



	def index1
		  if params[:search]
		@employees = Employ.find(:all,:conditions => ["(first_name LIKE ? OR last_name lIKE ?)","%#{params[:search]}%","#{params[:search]}%"]).paginate :page => params[:page],:per_page => 2
	  else
		@employees= Employ.find(:all).paginate :page => params[:page],:per_page => 2
	  end
		 respond_to do |format|	
		  format.html # new.html.erb
		  format.xml  { render :xml => @employees }
		end

	end

  def csv_import 
     @impcsv=CSV::Reader.parse(params[:impcsv][:passport])
     n=0
     @impcsv.each  do |row|
     c=Lead.new
     c.first_name=row[0]
     c.last_name=row[1]
     c.email=row[2]
     if c.save!
        n=n+1
        GC.start if n%50==0
      end
       
     end
     flash.now[:message]="CSV Import Successful,  #{n} new  records added to data base"
       redirect_to(:action=>'index1') and return
  end 






	def show
		@employ = Employ.find(params[:id])
		 respond_to do |format|	
		  format.js
		  format.html # new.html.erb
		  format.xml  { render :xml => @employ }
		end
	end
	
	def new
		@departments = GigavineDepartment.find(:all)
		 @emp = Employ.new
		 respond_to do |format|
		   format.js
		   format.html
		   format.xml  { render :xml => @emp }
		end
	end
	
	def create
		@emp = Employ.new(params[:employ])    
		    authorize! :create, Group      
		    @emp.author_id = current_user.id
		    respond_to do |format|
		      if @emp.save
			format.html { redirect_to(admin_employees_path, :notice => 'Employee was successfully created.') }
			format.xml  { render :xml => @emp, :status => :created, :location => @emp }
		      else
			      @departments = GigavineDepartment.find(:all)
			format.html { render :action => "new" }
			format.xml  { render :xml => @emp.errors, :status => :unprocessable_entity }
		      end
		    end
	end
	
	def edit
		@departments = GigavineDepartment.find(:all)
		@emp = Employ.find(params[:id])
		respond_to do |format|
		  format.js
		  format.html # new.html.erb 
		end		
	end
	
	def update
	   @emp = Employ.find(params[:id])	    
	    authorize! :update, @department	    
	    respond_to do |format|
	      if @emp.update_attributes(params[:employ].merge :author => current_user)
		 format.html { redirect_to(admin_employees_path, :notice => 'Employ has been successfully updated.') } 
		 format.xml  { render :xml => @emp, :status => :created, :location => @emp }
	      else   
		@departments = GigavineDepartment.find(:all)      
		format.html { render :action => "edit" }
		format.xml  { render :xml => @emp.errors, :status => :unprocessable_entity }
	      end
    end		
		
		
		
	end
	
	def destroy
		 @emp = Employ.find(params[:id])    
		  authorize! :destroy, @emp    
		 Group.where(:parent_id =>@emp.id).delete_all
		
		  @destroyed = @emp.destroy
		    respond_to do |format|
		      format.html { redirect_to admin_employees_path, :notice => 'Employ was successfully deleted.' }
		      format.xml  { head :ok }
		end
	end
	
	
	
end
