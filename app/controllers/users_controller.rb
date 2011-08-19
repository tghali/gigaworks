class UsersController < ActionController::Base
  include WardenHelper
  include UrlHelper
  protect_from_forgery
  
  before_filter :authenticate, :except => [:new, :create, :verify, :terms_and_conditions, :privacy_policy,:signup,:gigauser_create,:client_user_signup,:client_user_create]
  before_filter :ensure_user_is_not_signed_in, :only => [:new, :create]
  
  # before_filter :redirect_to_https, :except => [:verify, :privacy_policy, :terms_and_conditions]
  
  layout 'application'
  protect_from_forgery
  
  
  def signup
	 invite = Invite.where(:token => params[:invite_token]).first or raise ActiveRecord::RecordNotFound	
        @gigauser = Gigauser.find_by_gigaclient_id(invite.event_id)	
         gigaclient = Gigaclient.find(@gigauser.gigaclient_id)	
	     if !@gigauser.username.blank? && !@gigauser.hashed_password.blank?
		      
			redirect_to("http://#{gigaclient.gigadomain.subdomain}.#{request.domain}/sign_in", :notice => 'The invite has already been redeemed')
			return
		end
	 
 
     respond_to do |format|
      format.html {render :signup, :layout => false}
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to(sign_in_url, :notice => 'The invite code was not found in our database, if the problem persists please contact an administrator.')
 end


def gigauser_create
	@gigauser = Gigauser.find(params[:user_id])
	 respond_to do |format|
		 if @gigauser.update_attributes(params[:gigauser])
			 gigaclient = Gigaclient.find(@gigauser.gigaclient_id)
			 format.html { redirect_to "http://#{gigaclient.gigadomain.subdomain}.#{request.domain}/sign_in", :notice => "Congratulations, you succesfully registered. You can now log in"}
			
		 else
			 format.html {render :signup, :layout => false}
		end
       end
end

  
  #### Client User Signup

 def client_user_signup
	@invite = ClientContactInvite.where(:token => params[:invite_token]).first or raise ActiveRecord::RecordNotFound
    if @invite.status == 0	
	    @gigauser = Gigauser.new 
	     respond_to do |format|
	      format.html {render :client_user_signup, :layout => 'admin/user_signup'}
	    end
   else
			 gigaclient = Gigaclient.find(@invite.sender.gigaclient_id)
			  redirect_to "http://#{gigaclient.gigadomain.subdomain}.#{request.domain}/sign_in", :notice => "The invite has already been redeemed"	   
   end	   
  rescue ActiveRecord::RecordNotFound
    redirect_to(sign_in_url, :notice => 'The invite code was not found in our database, if the problem persists please contact an administrator.')
 end


def client_user_create
  @gfind = Gigauser.find(:last)
	@gigauser = Gigauser.new(params[:gigauser])
	 respond_to do |format|
     @gigauser.id = @gfind.id.to_i + 1
		 if @gigauser.save
			 @invite = ClientContactInvite.where(:token => params[:invite_token]).first
			 @invite.update_attribute(:status, 1)
			 gigaclient = Gigaclient.find(@gigauser.gigaclient_id)
			 format.html { redirect_to "http://#{gigaclient.gigadomain.subdomain}.#{request.domain}/sign_in", :notice => "Congratulations, you succesfully registered. You can now log in"}
		 else
			@invite = ClientContactInvite.where(:token => params[:invite_token]).first or raise ActiveRecord::RecordNotFound	
			format.html { render :action => "client_user_signup", :layout => 'admin/user_signup'}
		end
       end
end


#### Client User Signup End

  
  
  
  def new
    invite = Invite.where(:token => params[:invite_token]).first or raise ActiveRecord::RecordNotFound

    if invite.recipient.user
      redirect_to(sign_in_url, :notice => 'The invite has already been redeemed')
      return
    end

    @user = invite.recipient.build_user
    respond_to do |format|
      format.html {render :new, :layout => 'sessions'}
      format.xml  { render :xml => @word }
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to(sign_in_url, :notice => 'The invite code was not found in our database, if the problem persists please contact an administrator.')
  end
  
  def edit
    @user = current_user
    @user.password = nil
    @user.password_confirmation = nil
  end
  
  def create
    invite = Invite.where(:token => params[:invite_token]).first or raise ActiveRecord::RecordNotFound
    
    if invite.recipient.user
      redirect_to(sign_in_url, :notice => 'The invite has already been redeemed') and return
    end
    
    @user = invite.recipient.build_user(params[:user])
    @user.status = :verified
    
    respond_to do |format|
      if @user.save 
        format.html { redirect_to sign_in_url, :notice => "Congratulations, you succesfully registered. You can now log in"}
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :new, :layout => 'sessions' }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end      
    end#end respond_to
  end
  
  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      warden.set_user @user # updates the salt if the password is changed
      flash[:success] = 'Your profile was updated.'
      render :action => 'edit'
    else
      render :action => 'edit'
    end
  end
  
  def feedback
    @user = current_user
    
    raise ActiveRecord::RecordNotFound if current_user.client
    
    render
  end
  
  # TODO: create a landing page for email account verification
  def verify
    token = UserVerificationKey.find_by_token(params[:verification_token]) or ActiveRecord::RecordNotFound
    @user = token.user
    begin
      @user.verified!
      current_session.user = @user
      flash[:notice] = verified
      redirect_to sign_in_path
    rescue
      flash[:error] = @user.verification_key.errors.on(:base)
      render :action => 'new', :status => :unauthorized
    end
  end

# FIXME: this is a duplicate.
protected

  def ensure_user_is_not_signed_in
    if current_user
      redirect_to "http://worx.#{request.domain}", :notice => "You are currently signed in. The action you requested will require you to sign out." and return
    end
  end
  
  # FIXME: this kills the url parameters during protocol redirection
  def redirect_to_https
      redirect_to :protocol => "https://" unless (request.ssl? || request.local?)
  end
end
