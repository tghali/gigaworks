class SessionsController < ActionController::Base
  
  before_filter :redirect_to_https
  
  include WardenHelper
  protect_from_forgery
  
  def new
    redirect_to root_url if warden.authenticated?
  end
  
  def create
    if current_user
      flash.now[:alert] = t(:'account.already_signed_in')
      redirect_to root_url
    end
    warden.authenticate! :remember, :sign_in
    Rails.logger.info "[Sign In: success] from #{request.remote_ip} - #{current_user.id}"
    redirect_to gigaworks_dashboard_url
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
    flash.now[:error] = t(env['warden.options'][:message]) if env['warden.options'][:message]
    Rails.logger.info "[Sign In: fail] from #{request.remote_ip} - #{params[:user_name_or_email]} #{t(env['warden.options'][:message])}"
    cookies.delete('_gigavine_warden')
    render :action => "new", :status => :unauthorized
  end

protected

  def redirect_to_https
      redirect_to :protocol => "https://" unless (request.ssl? || request.local?)
  end
  
end