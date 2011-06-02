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
  
private
  def set_locale
    I18n.locale = params[:locale] || :en
  end
end
