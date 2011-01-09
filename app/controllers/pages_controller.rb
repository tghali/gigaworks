class PagesController < ActionController::Base
  
  rescue_from ActionView::MissingTemplate do
    raise ActionController::RoutingError.new "#{params[:section]}/#{params[:page]} is not a static page in the application"
  end

  def show
    if params[:page]
      render "#{params[:section]}_#{params[:page]}"
    else
      render params[:section]
    end
  end
  
end
