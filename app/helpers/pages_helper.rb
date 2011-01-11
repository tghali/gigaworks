module PagesHelper
  
  # Keeps the locale in the url and adds an active class to the link tag if the link points to the current page.
  def link_to *args
    if args.second.is_a? Hash
      args.second.merge!(:locale => params[:locale]) if params[:locale]
      
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
        links << link_to(locale, current_page.merge(:locale => locale), :class => locale).html_safe
      end
    end
  end

private
  
  def current_page
    @current_page ||= {:locale  => params[:locale],
                       :section => params[:section],
                       :page    => params[:page]}.delete_if {|k,v| v == nil}
  end

end
