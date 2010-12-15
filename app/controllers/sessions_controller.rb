class SessionsController < ActionController::Base
  include WardenHelper
  protect_from_forgery

  def new
    redirect_to root_url if warden.authenticated?
  end
  
  def create
    warden.authenticate! :remember, :sign_in
    redirect_to root_url
  end
  
  def destroy
    warden.logout
    render :action => "new"
  end
  
  def unauthorized
    # @session = params[:session].except[:password] if params[:session]
    flash.now[:error] = t(env['warden.options'][:message]) if env['warden.options'][:message]
    render :action => "new", :status => :unauthorized
  end
end
