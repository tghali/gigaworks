class SessionsController < ActionController::Base
  
  # before_filter :redirect_to_https
  layout  false 
  include WardenHelper
  include UrlHelper
  protect_from_forgery
  
  def new   	 
    redirect_to root_url if warden.authenticated?

  end
  

  
  
  
  def create
	  
	  
    if current_user
      flash[:alert] = t(:'account.already_signed_in')
      redirect_to "http://worx.#{request.domain}/" and return
    end
    
    warden.authenticate! :sign_in

   
    Rails.logger.info "[Sign In: success] from #{request.remote_ip} - #{current_user.id}"
    #~ if request.referrer == "http://gigavine.com:4006/admin"
	     #~ redirect_to "http://admin.#{request.domain}:4006/groups"
    #~ else
    
  gigauser = Gigauser.find(current_user.id)
	gigadomain = Gigadomain.find_by_gigaclient_id(gigauser.gigaclient_id)
    	 #~ gigadomain = Gigadomain.find_by_id(current_user.id)
	    if gigadomain
          #~ render :text => "Subdomain" and return
		    redirect_to "http://#{gigadomain.subdomain}.gigavine.com/welcome" and return
	    else
        #~ render :text => "worx.gigavine.com" and return
		    redirect_to "http://worx.#{request.domain}/admin/employees/dashboard" 
	    end
    #~ end
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
    message = env['warden.options'][:message] || warden.message
    flash[:error] = message

    Rails.logger.info "[Sign In: fail] from #{request.remote_ip} - #{message}"
    session[:remember_me] = nil
    render :action => "new", :status => :unauthorized
  end
  
protected

  def redirect_to_https
      redirect_to :protocol => "https://" unless (request.ssl? || request.local?)
  end
  
end