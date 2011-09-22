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
    @page_title = "Gigavine - Languages"
	   render :layout => 'pages_new'
   end
   
  def language_translation	
    @page_title = "Gigavine - Languages - Translation"
     render :layout => 'pages_new'
  end    
 
   def language_localisation
    @page_title = "Gigavine - Languages - Localisation"
     render :layout => 'pages_new'
   end    

  def language_consultancy
    @page_title = "Gigavine - Languages - Consultancy"
     render :layout => 'pages_new'
  end    
   
  def language_tools
    @page_title = "Gigavine - Languages - Online Tools"
     render :layout => 'pages_new'
  end    




  def creative_new
        @page_title = "Gigavine - Creative"
    	   render :layout => 'pages_new'
  end    
 
   def creative_work
     @page_title = "Gigavine - Creative - Artwork"
     render :layout => 'pages_new'
  end
 
 def technology_new
   @page_title = "Gigavine - Technology"
   render :layout => 'pages_new'
 end
 
 def technology_learning
    @page_title = "Gigavine - Technology - E-Learning"
   render :layout => 'pages_new'
 end 
  
  
   def network_land
	 render :layout => 'pages_new'
 end
  
   def network_featured
   render :layout => false
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

   def language_create
	 find_page = FrontendPage.find_by_page_section(params[:languages_page][:page_section])
	 if find_page.blank?
		@frontend_page = FrontendPage.new(params[:languages_page])
		@frontend_page.user_id = 2	 
		@frontend_page.page_section = params[:languages_page][:page_section]
		@frontend_page.save
	else
		find_page.update_attributes(params[:languages_page])
	end
	 redirect_to :action => "languages_new"
 end

    def creative_create
	 find_page = FrontendPage.find_by_page_section(params[:creative_page][:page_section])
	 if find_page.blank?
		@frontend_page = FrontendPage.new(params[:creative_page])
		@frontend_page.user_id = 2	 
		@frontend_page.page_section = params[:creative_page][:page_section]
		@frontend_page.save
	else
		find_page.update_attributes(params[:creative_page])
	end
	 redirect_to :action => "creative_new"
 end
  
    def banner_create
    #~ render :text => params.inspect and return
    
	 find_page = FrontendPage.find_by_page_section(params[:banner_page][:page_section])
	 if find_page.blank?
		@frontend_page = FrontendPage.new(params[:banner_page])
		@frontend_page.user_id = 2	 
		@frontend_page.page_section = params[:banner_page][:page_section]
		@frontend_page.save
	else
		find_page.update_attributes(params[:banner_page])
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


 def page_data(tab_type)	 
	 if tab_type == "create"
		 return "home_create"
	 elsif tab_type == "adapt"
		 return "home_adapt"
	 elsif tab_type == "deliver"
		 return "home_deliver"
	 elsif tab_type == "middle_content"
		 return "home_middle"	
         elsif tab_type == "news_block"	
		  return "home_news_block"	
	 end
 end 









  
private
  def set_locale
    I18n.locale = params[:locale] || :en
  end
end
