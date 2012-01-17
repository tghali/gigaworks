class PagesController < ActionController::Base
  include WardenHelper
  
  before_filter :get_user_ip, :only => [:languages_new, :languages_writing,:language_translation,:language_localisation,:language_consultancy,:get_estimate]

  before_filter :set_locale
  #~ before_filter :authenticate_as_admin, :except => :temp_home
  
  rescue_from ActionView::MissingTemplate do
    raise ActionController::RoutingError.new "#{params[:section]}/#{params[:page]} is not a static page in the application"
  end

  def meta_data(section)

        meta_detail=FrontendPage.find_by_page_section(section)
       @page_description=meta_detail.content if meta_detail
      @page_keywords=meta_detail.news if meta_detail
  end
 def get_estimates
@estimates=Estimate.all
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
   if request.env['HTTP_REFERER'] == "http://gigablog.heroku.com/"
    flash[:error]= "visible"
  end

    if request.url != 'http://gigavine.com/' and request.url != 'http://gigavine.com/home' and request.url != 'http://www.gigavine.com/'
	#render :text => request.url and return
      redirect_to :controller => 'pages', :action => 'temp_home' and return
    end
        meta_data('home_seo')
get_estimates
	  render :layout => 'pages_new'
  end

def new_estimate
 @estimate=Estimate.create(params[:estimate])
 redirect_to :action => "languages_new"
end
def delete_estimate
  @estimate=Estimate.find(params[:id])
  @estimate.destroy
  redirect_to :action => "languages_new"
  
end
  
  def languages_new
    @page_title = "Gigavine - Languages"
meta_data('language_main_seo')
get_estimates
	   render :layout => 'pages_new'
   end
     def company_new
get_estimates
meta_data('company_main_seo')
    @page_title = "Gigavine - Company"
	   render :layout => 'pages_new'
   end
  def company_about
get_estimates
meta_data('company_about_seo')
    @page_title = "Gigavine - Company - About"
	   render :layout => 'pages_new'
   end
  def company_value
get_estimates
meta_data('company_values_seo')
    @page_title = "Gigavine - Company - Value"
	   render :layout => 'pages_new'
   end
   
  def languages_writing
get_estimates
meta_data('language_copy_seo')
    @page_title = "Gigavine - Languages - Copywriting"
    render :layout => 'pages_new'
  end

  def language_translation
get_estimates	
meta_data('language_translate_seo')
    @page_title = "Gigavine - Languages - Translation"
     render :layout => 'pages_new'
  end    
 
   def language_localisation
get_estimates
meta_data('language_local_seo')
    @page_title = "Gigavine - Languages - Localisation"
     render :layout => 'pages_new'
   end    

  def language_consultancy
get_estimates
meta_data('language_consult_seo')
    @page_title = "Gigavine - Languages - Consultancy"
     render :layout => 'pages_new'
  end    


  def creative_new
get_estimates
meta_data('creative_main_seo')
        @page_title = "Gigavine - Creative"
    	   render :layout => 'pages_new'
  end    

  def creative_adv
get_estimates
meta_data('creative_advert_seo')
    @page_title = "Gigavine - Creative - Advertisement"
    render :layout => 'pages_new'
  end

   def creative_work
get_estimates
meta_data('creative_artwork_seo')
     @page_title = "Gigavine - Creative - Artwork"
     render :layout => 'pages_new'
  end
 
   def creative_design
get_estimates
meta_data('creative_design_seo')
    @page_title = "Gigavine - Creative - Webdesign"
    render :layout => 'pages_new'
  end

  #~ def creative_writing
    #~ @page_title = "Gigavine - Creative - Copywriting"
    #~ render :layout => 'pages_new'
  #~ end

  def creative_interactive
get_estimates
meta_data('creative_interactive_seo')
    @page_title = "Gigavine - Creative - Interactive"
    render :layout => 'pages_new'
  end

 
 
 
 def technology_new
get_estimates
meta_data('technology_main_seo')
   @page_title = "Gigavine - Technology"
   render :layout => 'pages_new'
 end
 
 def technology_learning
get_estimates
meta_data('technology_learn_seo')
    @page_title = "Gigavine - Technology - E-Learning"
   render :layout => 'pages_new'
 end 

 def technology_commerce
get_estimates
meta_data('technology_commerce_seo')
   @page_title = "Gigavine - Technology - E-Commerce"
   render :layout => 'pages_new'
 end
  
  def technology_secure
get_estimates
meta_data('technology_security_seo')
   @page_title = "Gigavine - Technology - Online Security"
   render :layout => 'pages_new'
 end
 
    def technology_tools
get_estimates
meta_data('tech_online_tools_seo')
    @page_title = "Gigavine - Technology - Online Tools"
     render :layout => 'pages_new'
  end  
  #~ def technology_crm
   #~ @page_title = "Gigavine - Technology - CRM"
   #~ render :layout => 'pages_new'
 #~ end
  
    def projects_land
get_estimates
   @page_title = "Gigavine - Projects"
   render :layout => 'pages_new'    
  end
 
   def projects_case_studies
get_estimates
   @page_title = "Gigavine - Projects - Case Studies"
   render :layout => 'pages_new'    
  end
  
  
   def network_land
get_estimates
	 render :layout => 'pages_new'
 end
  
   def network_featured
get_estimates
   render :layout => false
 end
 
     def network_registration
get_estimates
        @talent = Talent.new
         		 respond_to do |format|
		   format.html { render :layout => false   }
		   format.xml  { render :xml => @talent }
	
		end
	
  end
  
   def contactus
get_estimates
meta_data('company_contact_seo')
     @page_title = "Gigavine - Contact Us"
    render :layout => 'pages_new'
 end
	 def privacypolicy
get_estimates
    render :layout => 'pages_new'  
 end
 def terms
get_estimates
    render :layout => 'pages_new'  
 end
  
   def submenu
get_estimates
     render :layout => false  
 end
 
 def home_create
	 page_section = page_data(params[:frontend_page][:tab_type])
	 
	 find_page = FrontendPage.find_by_page_section(page_section)
	 if find_page.blank?
		@frontend_page = FrontendPage.new(params[:frontend_page])
		#@frontend_page.user_id = 2	 
                @frontend_page.user_id = current_user.id
		@frontend_page.page_section = page_section
		@frontend_page.ippadd = request.remote_ip
		@frontend_page.save
	else
		find_page.update_attributes(params[:frontend_page])
		find_page.update_attribute(:ippadd, request.remote_ip)
	end
	 redirect_to :action => "home_land"
 end

   def language_create
	 find_page = FrontendPage.find_by_page_section(params[:languages_page][:page_section])
	 if find_page.blank?
		@frontend_page = FrontendPage.new(params[:languages_page])
		@frontend_page.user_id = 2	 
		@frontend_page.page_section = params[:languages_page][:page_section]
                @frontend_page.ippadd = request.remote_ip
		@frontend_page.save
	else
		find_page.update_attributes(params[:languages_page])
                find_page.update_attribute(:ippadd, request.remote_ip)
	end
  
  if params[:languages_page][:page_section] == 'languages_page'|| params[:languages_page][:page_section] == 'language_main_seo'
	 redirect_to :action => "languages_new"
  elsif params[:languages_page][:page_section] == 'language_consultancy_page' || params[:languages_page][:page_section] == 'language_consult_seo'
    redirect_to :action => "language_consultancy"
  elsif params[:languages_page][:page_section] == 'language_translation_page'|| params[:languages_page][:page_section] == 'language_translate_seo'
        redirect_to :action => "language_translation"
  elsif params[:languages_page][:page_section] == 'language_copy_seo'
    redirect_to :action => "languages_writing"
  elsif params[:languages_page][:page_section] == 'language_localisation_page' || params[:languages_page][:page_section] == "lang_localisation_products" || params[:languages_page][:page_section] == "lang_localisation_websites" || params[:languages_page][:page_section] == "lang_localisation_software" || params[:languages_page][:page_section] == "lang_localisation_mobile" || params[:languages_page][:page_section] == "lang_localisation_subtitle"|| params[:languages_page][:page_section] == 'language_local_seo'
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
                @frontend_page.ippadd = request.remote_ip
		@frontend_page.save
	else
		find_page.update_attributes(params[:creative_page])
 		find_page.update_attribute(:ippadd, request.remote_ip)
	end
  
      if params[:creative_page][:page_section] == 'creative_page'||params[:creative_page][:page_section] == 'creative_main_seo'
	 redirect_to :action => "creative_new"
  elsif params[:creative_page][:page_section] == 'languages_copywriting_page'
    redirect_to :action => "languages_writing"
  elsif params[:creative_page][:page_section] == 'creative_artwork_page' || params[:creative_page][:page_section] == 'creative_artwork_seo'
        redirect_to :action => "creative_work"
  elsif params[:creative_page][:page_section] == 'creative_adv_page' || params[:creative_page][:page_section] == "creative_press_adv" || params[:creative_page][:page_section] == "creative_outdoor_adv" || params[:creative_page][:page_section] == "creative_online_adv" || params[:creative_page][:page_section] == "creative_adv_exhibition" || params[:creative_page][:page_section] == 'creative_advert_seo'
    redirect_to :action => "creative_adv" 
  elsif params[:creative_page][:page_section] == 'creative_webdesign_page' || params[:creative_page][:page_section] == 'creative_design_seo'
        redirect_to :action => "creative_design"
  elsif params[:creative_page][:page_section] == 'creative_interactive_page' || params[:creative_page][:page_section] == 'creative_mobile_development' || params[:creative_page][:page_section] == 'creative_ebooks' || params[:creative_page][:page_section] == 'creative_media_presentations' || params[:creative_page][:page_section] == 'creative_interactive_seo'
        redirect_to :action => "creative_interactive" 
  elsif params[:creative_page][:page_section] == 'contact_page' || params[:creative_page][:page_section] == 'contact_page_london' || params[:creative_page][:page_section] == 'contact_page_dubai'|| params[:creative_page][:page_section] == 'contact_page_newyork'|| params[:creative_page][:page_section] == 'company_contact_seo'

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
                @frontend_page.ippadd = request.remote_ip
		@frontend_page.save
	else
		find_page.update_attributes(params[:technology_page])
 		find_page.update_attribute(:ippadd, request.remote_ip)
	end
    if params[:technology_page][:page_section] == 'technology_page' || params[:technology_page][:page_section] == 'technology_main_seo'
      redirect_to :action => "technology_new"
   elsif params[:technology_page][:page_section] == 'tech_learning_page' || params[:technology_page][:page_section] == 'block1' || params[:technology_page][:page_section] == 'block2' || params[:technology_page][:page_section] == 'block3' || params[:technology_page][:page_section] == 'block4' || params[:technology_page][:page_section] == 'block5'|| params[:technology_page][:page_section] == 'technology_learn_seo'
     redirect_to :action => "technology_learning" 
   elsif params[:technology_page][:page_section] == 'tech_crm_page' || params[:technology_page][:page_section] == 'technology_crm_seo'
      redirect_to :action => "technology_crm"
   elsif params[:technology_page][:page_section] == 'tech_security_page' || params[:technology_page][:page_section] == 'technology_security_seo'
      redirect_to :action => "technology_secure"
   elsif params[:technology_page][:page_section] == 'tech_commerce_page' || params[:technology_page][:page_section] == 'technology_commerce_seo'
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
                @frontend_page.ippadd = request.remote_ip
		@frontend_page.save
	else
	
		find_page.update_attributes(params[:projects_page])
 		find_page.update_attribute(:ippadd, request.remote_ip)
	end
	 redirect_to :action => "projects_case_studies"
 end
 
   def company_create
	 find_page = FrontendPage.find_by_page_section(params[:company_page][:page_section])
	 if find_page.blank?
		@frontend_page = FrontendPage.new(params[:company_page])
		@frontend_page.user_id = 2	 
		@frontend_page.page_section = params[:company_page][:page_section]
                @frontend_page.ippadd = request.remote_ip
		@frontend_page.save
	else
		find_page.update_attributes(params[:company_page])
 		find_page.update_attribute(:ippadd, request.remote_ip)
	end
  
      if params[:company_page][:page_section] == 'company_new' || params[:company_page][:page_section] == 'company_main_seo'
	 redirect_to :action => "company_new"
      elsif params[:company_page][:page_section]=='company_about'|| params[:company_page][:page_section]=='company_about_seo'
	 redirect_to :action => "company_about"	
      elsif params[:company_page][:page_section]=='company_value' || params[:company_page][:page_section]=='company_values_seo'
	 redirect_to :action => "company_value"	
      end
end
  
  
    def banner_create
    #~ render :text => params.inspect and return
    
	 find_page = FrontendPage.find_by_page_section(params[:banner_page][:page_section])
	 if find_page.blank?
		@frontend_page = FrontendPage.new(params[:banner_page])
		@frontend_page.user_id = 2	 
		@frontend_page.page_section = params[:banner_page][:page_section]
                @frontend_page.ippadd = request.remote_ip
		@frontend_page.save
	else
		find_page.update_attributes(params[:banner_page])
 		find_page.update_attribute(:ippadd, request.remote_ip)
	end
	 redirect_to :action => "home_land"
 end
  
    def help_connect     
	 find_page = FrontendPage.find_by_page_section(params[:help_connect][:page_section])
	 if find_page.blank?
		@frontend_page = FrontendPage.new(params[:help_connect])
		@frontend_page.user_id = 2	 
		@frontend_page.page_section = params[:help_connect][:page_section]
                @frontend_page.ippadd = request.remote_ip
		@frontend_page.save
	else
	
		find_page.update_attributes(params[:help_connect])
 		find_page.update_attribute(:ippadd, request.remote_ip)
	end
	 redirect_to :action => "home_land"
 end
  
  	def submit_brief_pages 
        briefdetail = BriefDetail.new(params[:brief_detail])
        browser_detail = request.env['HTTP_USER_AGENT']
        ipadd=request.remote_ip
        get_user_ip
        loc=@country_name
      respond_to do |format|
        if briefdetail.save! 
          UserMailer.submit_brief(briefdetail,params[:brief_detail][:attachment].path,params[:section_name], browser_detail,ipadd,loc).deliver 
	  format.html { redirect_to("http://www.gigavine.com/technology#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Technology main"	
          format.html { redirect_to("http://www.gigavine.com/technology/e-learning#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Technology learning"  
          format.html { redirect_to("http://www.gigavine.com/technology/e-commerce#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Technology commerce"  
          format.html { redirect_to("http://www.gigavine.com/technology/online-tools#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Technology tools"  
          format.html { redirect_to("http://www.gigavine.com/technology/online-security#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Technology secure"  
          format.html { redirect_to("http://www.gigavine.com/creative#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Creative main"  
          format.html { redirect_to("http://www.gigavine.com/creative/artwork#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Creative work"  
          format.html { redirect_to("http://www.gigavine.com/creative/advertising#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Creative adv"  
          format.html { redirect_to("http://www.gigavine.com/creative/webdesign#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Creative design"  
          format.html { redirect_to("http://www.gigavine.com/creative/interactive#submit", :notice => "Your brief has been submitted successfully, one of our project managers will be in-touch shortly.") } if params[:section_name]=="Creative interactive"  
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
         elsif tab_type == "home_seo"
                  return "home_seo"	
	 end
 end 

def get_estimate
  @amount = 0
  @estimates=Estimate.all


  if params[:source]!='Select' and params[:target]!='Select'
   
    if !params[:words].blank?
      for e in @estimates
        if params["#{e.service}".to_sym]
          @amount = @amount + ((params[:words].to_i/250)*(e.cost).to_i)
         puts "@ammount ... #{@amount} #{e.service} #{e.cost}"
        end
      end

    end
    if !params[:pages].blank?
      for e in @estimates
        if params["#{e.service}".to_sym]
          @amount = @amount + ((params[:pages].to_i)*(e.cost).to_i)
         puts "@ammount ... #{@amount} #{e.service} #{e.cost}"
        end
      end
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

def search_site

  if !params[:search_form][:search].blank?
  
    @frontend =FrontendPage.all
    @sections = []
    @query=params[:search_form][:search]
    for string in @frontend
      if !(string.title).blank?     
        if string.title.include?(@query)
          @sections << string.page_section
        end 
      end
      if !(string.content).blank?
        if string.content.include?(@query)
          @sections << string.page_section
        end
      end
    end
  end
  @sections.uniq!
  @a_sections=[]
  for s in @sections
    puts "hello #{s}"
    case s
      when 'languages_page'
        s ='Languages'
      when 'language_translation_page'
        s ='Languages'
      when 'lang_trans_technical'
        s ='Languages'
     when 'lang_trans_medical'
        s ='Languages'
     when 'lang_trans_marketing'
        s ='Languages'
     when 'lang_trans_literary'
        s ='Languages'
     when 'language_localisation_page'
        s ='Languages'
     when 'lang_localisation_products'
        s ='Languages'
     when 'lang_localisation_websites'
        s ='Languages'
     when 'lang_localisation_software'
        s ='Languages'
     when 'lang_localisation_mobile'
        s ='Languages'
     when 'lang_localisation_subtitle'
        s ='Languages'
     when 'language_consultancy_page'
        s ='Languages'
     when 'tech_online_tools'
        s ='Technology'
     when 'creative_page'
        s ='Creative'
     when 'creative_artwork_page'
        s ='Creative'
     when 'creative_adv_page'
        s ='Creative'
     when 'creative_press_adv'
        s ='Creative'
     when 'creative_outdoor_adv'
        s ='Creative'
     when 'creative_online_adv'
        s ='Creative'
     when 'creative_adv_exhibition'
        s ='Creative'
     when 'creative_webdesign_page'
        s ='Creative'
     when 'languages_copywriting_page'
        s ='Languages'
     when 'creative_interactive_page'
        s ='Creative'
     when 'creative_mobile_development'
        s ='Creative'
     when 'creative_ebooks'
        s ='Creative'
     when 'technology_page'
        s ='Technology'
     when 'tech_learning_page'
        s ='Technology'
     when 'block1'
       s ='Technology'
     when 'block2'
        s ='Technology'
     when 'block3'
        s ='Technology'
     when 'block4'
        s ='Technology'
     when 'block5'
        s ='Technology'
     when 'tech_commerce_page'
        s ='Technology'
     when 'tech_security_page'
        s ='Technology'
     when 'tech_crm_page'
        s ='Technology'
     when 'project_land_page'
        s ='Project'
     when 'project_case_study_page'
        s ='Project'
     when 'project_cstudies_challenge'
        s ='Project'
     when 'project_cstudies_benefits'
        s ='Project'
     when 'company_new'
        s ='Company'
     when 'company_about'
        s ='Company'
     when 'company_value'
        s ='Company'
     when 'create'
       s ='Home'
     when 'adapt'
       s ='Home'
     when 'deliver'
       s ='Home'
     when 'middle_content'
       s ='Home'
     when 'news_block' 
       s ='Home'
     when 'home_adapt' 
       s ='Home'
     when 'home_deliver' 
       s ='Home'
     when 'language_online_tools'
        s ='Languages'
     when 'creative_copywriting_page'
        s ='Creative'
     else
       s=''
   end
  if s!=''
     @a_sections << s
  end

  end
  @key=params[:search_form][:search]
  @a_sections.uniq!
  #params[:query]=nil
render :layout => 'pages_new'  
end

def get_user_ip
     ip_address =   request.remote_ip #request.env['REMOTE_ADDR'] #request.env["HTTP_X_FORWARDED_FOR"] #request.remote_ip
     #~ 209.85.227.104 ---- US
     #  62.232.30.75 ----- UK
     ip_info = GeoIp.geolocation(ip_address, :precision => :country)     
     @country_code = ip_info[:country_code] 
     @country_name=ip_info[:country_name]

end
  
private
  def set_locale
    I18n.locale = params[:locale] || :en
  end
end
