class SessionsController < ActionController::Base
  
  # before_filter :redirect_to_https
  layout  false 
  include WardenHelper
  include UrlHelper
  protect_from_forgery
  
  def new   	

      if !session["warden.user.default.key"].blank?
          gigauser = Gigauser.find(current_user.id)
          if gigauser
            gigadomain = Gigadomain.find_by_gigaclient_id(gigauser.gigaclient_id)
              if gigadomain
                redirect_to "http://#{gigadomain.subdomain}.#{request.domain}/dashboard" and return
              else
                redirect_to "http://worx.#{request.domain}/admin/employees/dashboard" and return  
              end
	      end
	 
     else
          redirect_to root_url if warden.authenticated?
     end
  end

  
  def create	  
    if current_user
      flash[:alert] = t(:'account.already_signed_in')
      redirect_to "http://worx.#{request.domain}/" and return
    end
    #if params[:recaptcha_response_field]
    # if verify_recaptcha
    
    warden.authenticate! :sign_in

   
    Rails.logger.info "[Sign In: success] from #{request.remote_ip} - #{current_user.id}"
    #~ if request.referrer == "http://gigavine.com:4006/admin"
	     #~ redirect_to "http://admin.#{request.domain}:4006/groups"
    #~ else
    
  gigauser = Gigauser.find_by_id(current_user.id)
	gigadomain = Gigadomain.find_by_gigaclient_id(gigauser.gigaclient_id) if !gigauser.blank?
    	 #~ gigadomain = Gigadomain.find_by_id(current_user.id)
	    if gigadomain
          #~ render :text => "Subdomain" and return
		    redirect_to "http://#{gigadomain.subdomain}.gigavine.com/welcome" and return
	    else
        #~ render :text => "worx.gigavine.com" and return
		    redirect_to "http://worx.#{request.domain}/admin/employees/dashboard" and return
	    end
#end
#else

#end
render :action => "new"
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
    if params[:q]
      redirect_to "http://www.#{request.domain}/" 
      else
    render :action => "new"
    end
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
