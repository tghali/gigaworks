class PagesController < ActionController::Base
  include WardenHelper
  
  before_filter :set_locale
  #~ before_filter :authenticate_as_admin, :except => :temp_home
  
  rescue_from ActionView::MissingTemplate do
    raise ActionController::RoutingError.new "#{params[:section]}/#{params[:page]} is not a static page in the application"
  end

  def show
    if params[:page]
      render "pages/#{params[:section]}/#{params[:page]}"
    else
      render params[:section] || 'home'
    end
  end
  
  def temp_home
    render :layout => false
  end
  
  def home_land
	  render :layout => 'pages_new'
  end
  
  def languages_new
	   render :layout => 'pages_new'
  end
    def creative_new
    	   render :layout => 'pages_new'
  end    
 
 def technology_new
   render :layout => 'pages_new'
 end
  
   def submenu
     render :layout => false  
 end
 
 def home_create
	 page_section = page_data(params[:frontend_page][:tab_type])
	 
	 find_page = FrontendPage.find_by_page_section(page_section)
	 if find_page.blank?
		@frontend_page = FrontendPage.new(params[:frontend_page])
		@frontend_page.user_id = 2	 
		@frontend_page.page_section = page_section
		@frontend_page.save
	else
		find_page.update_attributes(params[:frontend_page])
	end
	 redirect_to :action => "home_land"
 end

  
  
  
  
    def index
	  	 @prospect = Prospect.new	
  end
  
def lead_create
	@prospect = Prospect.new(params[:prospect]) 
	respond_to do |format|
		if @prospect.save
			format.html { redirect_to('/', :notice => 'Thank you for register with us. Our Sales team will contact you soon...') }
			format.xml  { render :xml => @prospect, :status => :created, :location => @prospect }
		else
		     
			format.html { render :action => "index" }
			format.xml  { render :xml => @prospect.errors, :status => :unprocessable_entity }
		end
	end
end



 	def submit_brief
	@briefdetail = BriefDetail.new(params[:briefdetail]) 
		    respond_to do |format|
			      if @briefdetail.save
				format.html { redirect_to({:action => 'show'}, :notice => 'Lead was successfully created.') }
				format.xml  { render :xml => @briefdetail, :status => :created, :location => @briefdetail }
			      else
				     
				format.html { render :action => "index" }
				format.xml  { render :xml => @briefdetail.errors, :status => :unprocessable_entity }
			      end
		    end
	    end












  
private
  def set_locale
    I18n.locale = params[:locale] || :en
  end
end
