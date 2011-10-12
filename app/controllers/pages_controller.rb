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

  def creative_adv
    @page_title = "Gigavine - Creative - Advertisement"
    render :layout => 'pages_new'
  end

   def creative_work
     @page_title = "Gigavine - Creative - Artwork"
     render :layout => 'pages_new'
  end
 
   def creative_design
    @page_title = "Gigavine - Creative - Webdesign"
    render :layout => 'pages_new'
  end

  def creative_writing
    @page_title = "Gigavine - Creative - Copywriting"
    render :layout => 'pages_new'
  end

  def creative_interactive
    @page_title = "Gigavine - Creative - Interactive"
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

 def technology_commerce
   @page_title = "Gigavine - Technology - E-Commerce"
   render :layout => 'pages_new'
 end
  
  def technology_secure
   @page_title = "Gigavine - Technology - Online Security"
   render :layout => 'pages_new'
 end
 
  def technology_crm
   @page_title = "Gigavine - Technology - CRM"
   render :layout => 'pages_new'
 end
  
    def projects_land
   @page_title = "Gigavine - Projects"
   render :layout => 'pages_new'    
  end
 
   def projects_case_studies
   @page_title = "Gigavine - Projects - Case Studies"
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
  
  if params[:languages_page][:page_section] == 'languages_page'
	 redirect_to :action => "languages_new"
  elsif params[:languages_page][:page_section] == 'language_consultancy_page'
    redirect_to :action => "language_consultancy"
  elsif params[:languages_page][:page_section] == 'language_translation_page'
        redirect_to :action => "language_translation"
  elsif params[:languages_page][:page_section] == 'language_localisation_page' || params[:languages_page][:page_section] == "lang_localisation_products" || params[:languages_page][:page_section] == "lang_localisation_websites" || params[:languages_page][:page_section] == "lang_localisation_software" || params[:languages_page][:page_section] == "lang_localisation_mobile" || params[:languages_page][:page_section] == "lang_localisation_subtitle"
        redirect_to :action => "language_localisation"
  elsif params[:languages_page][:page_section] == 'language_online_tools'
        redirect_to :action => "language_tools"
  else
    redirect_to :action => "language_translation"
  end

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
  
      if params[:creative_page][:page_section] == 'creative_page'
	 redirect_to :action => "creative_new"
  elsif params[:creative_page][:page_section] == 'creative_copywriting_page'
    redirect_to :action => "creative_writing"
  elsif params[:creative_page][:page_section] == 'creative_artwork_page'
        redirect_to :action => "creative_work"
  elsif params[:creative_page][:page_section] == 'creative_adv_page' || params[:creative_page][:page_section] == "creative_press_adv" || params[:creative_page][:page_section] == "creative_outdoor_adv" || params[:creative_page][:page_section] == "creative_online_adv" || params[:creative_page][:page_section] == "creative_adv_exhibition" 
    redirect_to :action => "creative_adv"
  elsif params[:creative_page][:page_section] == 'creative_webdesign_page'
        redirect_to :action => "creative_design"
  elsif params[:creative_page][:page_section] == 'creative_interactive_page' || params[:creative_page][:page_section] == 'creative_mobile_development' || params[:creative_page][:page_section] == 'creative_ebooks' || params[:creative_page][:page_section] == 'creative_media_presentations'
        redirect_to :action => "creative_interactive"
  else
    redirect_to :action => "creative_new"
  end
  
  
  
  
  
	 #~ redirect_to :action => "creative_new"
 end
  
    def technology_create
	 find_page = FrontendPage.find_by_page_section(params[:technology_page][:page_section])
	 if find_page.blank?
		@frontend_page = FrontendPage.new(params[:technology_page])
		@frontend_page.user_id = 2	 
		@frontend_page.page_section = params[:technology_page][:page_section]
		@frontend_page.save
	else
		find_page.update_attributes(params[:technology_page])
	end
    if params[:technology_page][:page_section] == 'technology_page'
      redirect_to :action => "technology_new"
   elsif params[:technology_page][:page_section] == 'tech_learning_page' || params[:technology_page][:page_section] == 'block1' || params[:technology_page][:page_section] == 'block2' || params[:technology_page][:page_section] == 'block3' || params[:technology_page][:page_section] == 'block4' || params[:technology_page][:page_section] == 'block5'
     redirect_to :action => "technology_learning"
   elsif params[:technology_page][:page_section] == 'tech_crm_page'
      redirect_to :action => "technology_crm"
   elsif params[:technology_page][:page_section] == 'tech_security_page'
      redirect_to :action => "technology_secure"
   elsif params[:technology_page][:page_section] == 'tech_commerce_page'
      redirect_to :action => "technology_commerce"
   else
	 redirect_to :action => "technology_new"
   end

 end
  
    def projects_create
    	 find_page = FrontendPage.find_by_page_section(params[:projects_page][:page_section])
	 if find_page.blank?
		@frontend_page = FrontendPage.new(params[:projects_page])
		@frontend_page.user_id = 2	 
		@frontend_page.page_section = params[:projects_page][:page_section]
		@frontend_page.save
	else
	
		find_page.update_attributes(params[:projects_page])
	end
	 redirect_to :action => "projects_land"
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
  
    def help_connect     
	 find_page = FrontendPage.find_by_page_section(params[:help_connect][:page_section])
	 if find_page.blank?
		@frontend_page = FrontendPage.new(params[:help_connect])
		@frontend_page.user_id = 2	 
		@frontend_page.page_section = params[:help_connect][:page_section]
		@frontend_page.save
	else
	
		find_page.update_attributes(params[:help_connect])
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
