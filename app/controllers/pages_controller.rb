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
  
    def index
	  	 @lead = Lead.new	
  end
  
def lead_create
	@lead = Lead.new(params[:lead]) 
	respond_to do |format|
		if @lead.save
			format.html { redirect_to('/', :notice => 'Thank you for register with us. Our Sales team will contact you soon...') }
			format.xml  { render :xml => @lead, :status => :created, :location => @lead }
		else
		     
			format.html { render :action => "index" }
			format.xml  { render :xml => @lead.errors, :status => :unprocessable_entity }
		end
	end
end
  
  
private
  def set_locale
    I18n.locale = params[:locale] || :en
  end
end
