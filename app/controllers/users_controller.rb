class UsersController < ActionController::Base
  include WardenHelper
  before_filter :authenticate, :except => [:new, :create]
  
  layout 'application'
  protect_from_forgery
  
  def new
    @user = User.new(:invite_token => params[:invite_token])
    @user.email = @user.beta_invite.recipient_email if @user.beta_invite
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @word }
    end
  end
  
  def edit
    @user = current_user
    @user.password = nil
    @user.password_confirmation = nil
  end
  
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save 
        UserMailer.deliver_verification @user
        flash[:notice] = "Congratulations, you succesfully registered. Soon you will receive an email with an activation link: click it to complete the registration."
        format.html { redirect_to root_url }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
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
  
  
end
