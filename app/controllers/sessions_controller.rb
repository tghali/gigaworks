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
  
  # Load user if the user has authenticated before with the provider.
  # Otherwise check for invitation tokens registered under that email address
  # otherwise create a new user account...
  
  # How to merge a facebook and a mail user account?!!?
  
  #well, because of the multiple profiles (sales etc) it might be even harder...
  
  
  def oauth
    raise request.env["omniauth.auth"].to_yaml
    # login the user if a
    
    # verify that the email in the account has a key, create a salt and blank out the hashed password
    
    #warden.authenticate! :oauth
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
