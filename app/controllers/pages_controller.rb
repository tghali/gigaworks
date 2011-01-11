class PagesController < ActionController::Base
  before_filter :set_locale
  
  rescue_from ActionView::MissingTemplate do
    raise ActionController::RoutingError.new "#{params[:section]}/#{params[:page]} is not a static page in the application"
  end

  def show
    if params[:page]
      render "#{params[:section]}_#{params[:page]}"
    else
      render params[:section] || 'home'
    end
  end
  
private
  def set_locale
    I18n.locale = params[:locale] || :en
  end
end
