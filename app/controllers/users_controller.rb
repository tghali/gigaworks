class UsersController < ActionController::Base
  include WardenHelper
  include UrlHelper
  protect_from_forgery
  
  before_filter :authenticate, :except => [:new, :create, :verify, :terms_and_conditions, :privacy_policy]
  before_filter :ensure_user_is_not_signed_in, :only => [:new, :create]
  
  # before_filter :redirect_to_https, :except => [:verify, :privacy_policy, :terms_and_conditions]
  
  layout 'application'
  protect_from_forgery
  
  def terms_and_conditions
    render :layout => 'sessions'
  end
  
  def privacy_policy
    render :layout => 'sessions'
  end
  
  def new
    invite = Invite.where(:token => params[:invite_token]).first or raise ActiveRecord::RecordNotFound
    redirect_to(sign_in_url, :notice => 'The invite has already been redeemed') if invite.recipient.user
    
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
    redirect_to(sign_in_url, :notice => 'The invite has already been redeemed') if invite.recipient.user
    
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
      if params[:action] == 'new'
        flash[:error] = "You are currently signed in. The action you requested will require you to sign out."
      else
        redirect_to :action => 'new'
      end
    end
  end
  
  # FIXME: this kills the url parameters during protocol redirection
  def redirect_to_https
      redirect_to :protocol => "https://" unless (request.ssl? || request.local?)
  end
end
