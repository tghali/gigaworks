class PagesController < ActionController::Base
  include WardenHelper
  
  before_filter :get_user_ip, :only => [:languages_new, :languages_writing,:language_translation,:language_localisation,:language_consultancy,:get_estimate]

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
       #if request.url != 'http://gigavine.com/'
      #redirect_to :controller => 'sessions', :action => 'new' and return
    #end
    render :layout => false
  end
  
  def home_land
    	#render :text => request.url and return

    if request.url != 'http://gigavine.com/' and request.url != 'http://gigavine.com/home' and request.url != 'http://www.gigavine.com/'
	#render :text => request.url and return
      redirect_to :controller => 'pages', :action => 'temp_home' and return
    end
	  render :layout => 'pages_new'
  end
  
  def languages_new
    @page_title = "Gigavine - Languages"
	   render :layout => 'pages_new'
   end
     def company_new
    @page_title = "Gigavine - Company"
	   render :layout => 'pages_new'
   end
  def company_about
    @page_title = "Gigavine - Company - About"
	   render :layout => 'pages_new'
   end
  def company_value
    @page_title = "Gigavine - Company - Value"
	   render :layout => 'pages_new'
   end
   
  def languages_writing
    @page_title = "Gigavine - Languages - Copywriting"
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

  #~ def creative_writing
    #~ @page_title = "Gigavine - Creative - Copywriting"
    #~ render :layout => 'pages_new'
  #~ end

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
 
    def technology_tools
    @page_title = "Gigavine - Technology - Online Tools"
     render :layout => 'pages_new'
  end  
  #~ def technology_crm
   #~ @page_title = "Gigavine - Technology - CRM"
   #~ render :layout => 'pages_new'
 #~ end
  
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
  
   def contactus
     @page_title = "Gigavine - Contact Us"
    render :layout => 'pages_new'
 end
	 def privacypolicy
    render :layout => 'pages_new'  
 end
 def terms
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
  elsif params[:languages_page][:page_section] == 'tech_online_tools'
        redirect_to :action => "technology_tools"
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
  elsif params[:creative_page][:page_section] == 'languages_copywriting_page'
    redirect_to :action => "languages_writing"
  elsif params[:creative_page][:page_section] == 'creative_artwork_page'
        redirect_to :action => "creative_work"
  elsif params[:creative_page][:page_section] == 'creative_adv_page' || params[:creative_page][:page_section] == "creative_press_adv" || params[:creative_page][:page_section] == "creative_outdoor_adv" || params[:creative_page][:page_section] == "creative_online_adv" || params[:creative_page][:page_section] == "creative_adv_exhibition" 
    redirect_to :action => "creative_adv"
  elsif params[:creative_page][:page_section] == 'creative_webdesign_page'
        redirect_to :action => "creative_design"
  elsif params[:creative_page][:page_section] == 'creative_interactive_page' || params[:creative_page][:page_section] == 'creative_mobile_development' || params[:creative_page][:page_section] == 'creative_ebooks' || params[:creative_page][:page_section] == 'creative_media_presentations'
        redirect_to :action => "creative_interactive"
  elsif params[:creative_page][:page_section] == 'contact_page' || params[:creative_page][:page_section] == 'contact_page_london' || params[:creative_page][:page_section] == 'contact_page_dubai'|| params[:creative_page][:page_section] == 'contact_page_newyork'

    redirect_to :action => "contactus"

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
	 redirect_to :action => "projects_case_studies"
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
  
  	def submit_brief_pages 
        briefdetail = BriefDetail.new(params[:brief_detail])
        browser_detail = request.env['HTTP_USER_AGENT']
      respond_to do |format|
        if briefdetail.save! 
          UserMailer.submit_brief(briefdetail,params[:brief_detail][:attachment].path,params[:section_name], browser_detail).deliver 
	  format.html { redirect_to("http://test.gigavine.com/technology#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Technology main"	
          format.html { redirect_to("http://test.gigavine.com/technology/e-learning#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Technology learning"  
          format.html { redirect_to("http://test.gigavine.com/technology/e-commerce#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Technology commerce"  
          format.html { redirect_to("http://test.gigavine.com/technology/online-tools#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Technology tools"  
          format.html { redirect_to("http://test.gigavine.com/technology/online-security#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Technology secure"  
          format.html { redirect_to("http://test.gigavine.com/creative#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Creative main"  
          format.html { redirect_to("http://test.gigavine.com/creative/artwork#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Creative work"  
          format.html { redirect_to("http://test.gigavine.com/creative/advertising#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Creative adv"  
          format.html { redirect_to("http://test.gigavine.com/creative/webdesign#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Creative design"  
          format.html { redirect_to("http://test.gigavine.com/creative/interactive#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Creative interactive"  
          format.html { redirect_to({:action => 'home_land'}, :notice => 'Your data submitted successfully.') } if params[:section_name]=="Home"  
      else
          format.html { redirect_to({:action => 'technology_new'}, :notice => 'There is problem to submit data. Please try again') } if params[:section_name]=="Technology main"	
          format.html { redirect_to({:action => 'technology_learning'}, :notice => 'There is problem to submit data. Please try again') }  if params[:section_name]=="Technology learning"  
          format.html { redirect_to({:action => 'technology_commerce'}, :notice => 'There is problem to submit data. Please try again') }  if params[:section_name]=="Technology commerce"  
              format.html { redirect_to({:action => 'technology_tools'}, :notice => 'There is problem to submit data. Please try again') } if params[:section_name]=="Technology tools"  
          format.html { redirect_to({:action => 'technology_secure'}, :notice => 'There is problem to submit data. Please try again') } if params[:section_name]=="Technology secure"  
          format.html { redirect_to({:action => 'creative_new'}, :notice => 'There is problem to submit data. Please try again') } if params[:section_name]=="Creative main"  
          format.html { redirect_to({:action => 'creative_work'}, :notice => 'There is problem to submit data. Please try again') } if params[:section_name]=="Creative work"  
          format.html { redirect_to({:action => 'creative_adv'}, :notice => 'There is problem to submit data. Please try again') } if params[:section_name]=="Creative adv"  
          format.html { redirect_to({:action => 'creative_design'}, :notice => 'There is problem to submit data. Please try again') } if params[:section_name]=="Creative design"  
          format.html { redirect_to({:action => 'creative_interactive'}, :notice => 'There is problem to submit data. Please try again') } if params[:section_name]=="Creative interactive"  
          format.html { redirect_to({:action => 'home_land'}, :notice => 'There is problem to submit data. Please try again') } if params[:section_name]=="Home"  
      end
   end
      #~ briefdetail = BriefDetail.new(params[:brief_detail])
      #~ respond_to do |format|
      #~ if briefdetail.save!
              #file_path = params[:briefdetail_file].path                  
                #name_file = params[:briefdetail_file].original_filename
      	#~ format.html { redirect_to({:action => 'technology_new'}, :notice => 'Your data submitted successfully.') }			
       
      #~ end
    #~ end
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

def get_estimate
  @amount = 0
  if !params[:words].blank? && params[:localisation] && params[:design] && params[:translation]
       calc_pages((params[:words].to_i/250),'trans_local_design')    
    elsif !params[:words].blank? && params[:localisation] && params[:design]
       calc_pages((params[:words].to_i/250),'local_and_design')
    elsif !params[:words].blank? && params[:translation] && params[:design]
       calc_pages((params[:words].to_i/250),'trans_and_design')
    elsif !params[:words].blank? && params[:translation] && params[:localisation]
       calc_pages((params[:words].to_i/250),'trans_and_localise')        
    elsif !params[:words].blank? && params[:design]
      calc_pages((params[:words].to_i/250),'design')    
    elsif !params[:words].blank? && params[:localisation]
      calc_pages((params[:words].to_i/250),'localisation')
    elsif !params[:words].blank? && params[:translation]
      calc_words(params[:words])

    #--pages---
    elsif !params[:pages].blank? && params[:localisation] && params[:design] && params[:translation]
       calc_pages(params[:pages],'trans_local_design')    
    elsif !params[:pages].blank? && params[:localisation] && params[:design]
       calc_pages(params[:pages],'local_and_design')
    elsif !params[:pages].blank? && params[:translation] && params[:design]
       calc_pages(params[:pages],'trans_and_design')
    elsif !params[:pages].blank? && params[:translation] && params[:localisation]
       calc_pages(params[:pages],'trans_and_localise')        
    elsif !params[:pages].blank? && params[:design]
      calc_pages(params[:pages],'design')    
    elsif !params[:pages].blank? && params[:localisation]
      calc_pages(params[:pages],'localisation')
    elsif !params[:pages].blank? && params[:translation]
      calc_pages(params[:pages],'translation')    
    end
  end
  

  
  	  respond_to do |format|	     
	      format.js	    
	    end
 

end

def calc_words(words)
    if words.to_i <= 250
        @amount = @amount + 30 
    else
        @amount = @amount + 0.12*words.to_i
    end  
end

def calc_pages(pages,option)
  @amount=0
  if option == 'trans_local_design'
    if pages.to_i <= 4
        @amount = @amount + 120
    else
        words = pages.to_i*250
        @amount = @amount + 8.75*pages.to_i + 13.75*pages.to_i + 0.12*words.to_i 
    end   
  elsif option == 'local_and_design'
    if pages.to_i <= 4
        @amount = @amount + 90
    else
        @amount = @amount + 8.75*pages.to_i + 13.75*pages.to_i
      end 
  elsif option == 'trans_and_design'
    if pages.to_i <= 4
        @amount = @amount + 85
    else  
        words = pages.to_i*250
        @amount = @amount + 0.12*words.to_i + 13.75*pages.to_i
    end       
  elsif option == 'trans_and_localise'
    if pages.to_i <= 4
        @amount = @amount + 65
    else  
        words = pages.to_i*250
        @amount = @amount + 0.12*words.to_i + 8.75*pages.to_i
    end        
  elsif option == 'localisation'
    if pages.to_i <= 4
        @amount = @amount + 35 
    else
        @amount = @amount + 8.75*pages.to_i
      end  
  elsif  option == 'design'
    if pages.to_i <= 4
        @amount = @amount + 55 
    else
        @amount = @amount + 13.75*pages.to_i
      end 
   elsif  option == 'translation'
    if pages.to_i <= 4
        @amount = @amount + 30 
    else
        words = pages.to_i*250
        @amount = @amount + 0.12*words.to_i
      end      
  end
end

def get_user_ip
     ip_address =   request.remote_ip #request.env['REMOTE_ADDR'] #request.env["HTTP_X_FORWARDED_FOR"] #request.remote_ip
     #~ 209.85.227.104 ---- US
     #  62.232.30.75 ----- UK
     ip_info = GeoIp.geolocation(ip_address, :precision => :country)     
     @country_code = ip_info[:country_code] 

end
  
private
  def set_locale
    I18n.locale = params[:locale] || :en
  end
end
