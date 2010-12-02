class PagesController < ApplicationController
  
  rescue_from ActionView::MissingTemplate do
    raise ActionController::RoutingError.new "pages/#{params[:id]} is not a static page in the application"
  end

  def show
    render params[:id]
  end
  
end
