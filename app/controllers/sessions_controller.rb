class SessionsController < ActionController::Base
  include WardenHelper
  protect_from_forgery

  def new
    redirect_to root_url if warden.authenticated?
  end
  
  def create
    
    warden.authenticate!
  end
  
  def destroy
    warden.logout
  end
  
  def unauthorized
    # @session = params[:session].except[:password] if params[:session]
    render :action => "new", :status => :unauthorized
  end
end
