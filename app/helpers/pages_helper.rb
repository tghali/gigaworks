module PagesHelper
  
  # Keeps the locale in the url and adds an active class to the link tag if the link points to the current page.
  def link_to *args
    if args.second.is_a? Hash
      args.second.merge!(:locale => params[:locale]) unless args.second[:locale]
      
      args.second[:locale] = nil if args.second[:locale] == I18n.default_locale

      if args.second == current_page
        args.third || args << {}
        args.third.merge!('class' => 'active')
        args[1] = '#' # blanks the url
      end
    end
    
    super *args

  end
  
  def locale_links
    Gigavine::Preferences.site_locales.inject([]) do |links, locale|
      if I18n.locale == locale
        links << link_to(locale, '#', :class => "#{locale} active").html_safe
      else
        str = link_to(locale, current_page.merge(:locale => locale), :class => locale).html_safe
        links << str
      end
    end
  end
  
  def li_class(section, page=nil)
    if params[:section] == section
      if (params[:page] == 'contact_us' or page == 'contact_us') and (page != params[:page])
        return false
      end
      'current'
    end
  end
  
  private
  
  def current_page
    @current_page ||= {:locale  => I18n.locale,
      :section => params[:section],
      :page    => params[:page]}.delete_if {|k,v| v == nil}
  end

  def get_data(tab_type)
	frontend_page =  FrontendPage.find_by_page_section(tab_type)
	frontend_page.content
  end

  def get_title(tab_type)
	frontend_page =  FrontendPage.find_by_page_section(tab_type)
	!frontend_page.blank? ? raw(frontend_page.title) : "Gigavine offers creative & technical services which cross borders & open minds" 
  end

  def get_news(tab_type)
	frontend_page =  FrontendPage.find_by_page_section(tab_type)
	!frontend_page.blank? ? raw(frontend_page.news) : "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec placerat orci congue enim dignissim sit amet porta metus ultrices."
  end

  def get_network(tab_type)
	frontend_page =  FrontendPage.find_by_page_section(tab_type)
  !frontend_page.blank? ? raw(frontend_page.network) : "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec placerat orci congue enim dignissim sit amet porta metus ultrices."
  end

  def get_contact(tab_type)
	frontend_page =  FrontendPage.find_by_page_section(tab_type)
  !frontend_page.blank? ? raw(frontend_page.contact_us) : "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec placerat orci congue enim dignissim sit amet porta metus ultrices."
  end




end
