require "rubygems"
require "active_merchant"
require 'resolv'
class UsersController < ActionController::Base
  include WardenHelper
  include UrlHelper
  protect_from_forgery
  
  before_filter :authenticate, :except => [:new, :create, :verify, :terms_and_conditions, :privacy_policy,:signup,:gigauser_create,:client_user_signup,:client_user_create,:create_client_registration,:client_signup, :talent_registration, :create_talent_registration, :login, :edit_client,:edit_talent, :logout, :update_profile_talent, :edit_talent_contact, :edit_talent_profile, :logout, :validate_email, :client_billing,:update_profile_client]
  before_filter :ensure_user_is_not_signed_in, :only => [:new, :create,:create_client_registration,:client_signup, :talent_registration, :create_talent_registration, :login, :logout, :update_profile_talent, :edit_talent_contact, :edit_talent_profile,:edit_talent, :validate_email,:client_billing,:update_profile_client]
  
  # before_filter :redirect_to_https, :except => [:verify, :privacy_policy, :terms_and_conditions]
  
  layout 'application'
  protect_from_forgery
  
  
    def edit_client
@gigauser=Gigaclient.find(session[:user])
  
  respond_to do |format|
		   format.html { render :layout=>'pages_new'   }
		   format.xml  { render :xml => @gigauser }
	
		end
end
  
  def edit_talent
@talent=Talent.find(session[:user]) 
  
  respond_to do |format|
		   format.html { render :layout=>'pages_new'   }
		   format.xml  { render :xml => @gigauser }
	
		end
end
  def edit_talent_contact
@talent=Talent.find(session[:user]) 
  
  respond_to do |format|
		   format.html { render :layout=>'pages_new'   }
		   format.xml  { render :xml => @gigauser }
	
		end
end
def edit_talent_profile
@talent=Talent.find(session[:user])
  
  respond_to do |format|
		   format.html { render :layout=>'pages_new'   }
		   format.xml  { render :xml => @gigauser }
	
		end
end
  def login
   @gigauser=Gigauser.find_by_username(params[:login][:username])
  if @gigauser

      if @gigauser.role == 'Talent'
         redirect_to talentedit_users_path(:user => @gigauser.gigaclient_id)
         cookies[:username]=@gigauser.username
         cookies[:password]=@gigauser.password
         session[:user]=@gigauser.gigaclient_id
       elsif @gigauser.role=='Client'
          #flash[:error]="yet to come"
          #redirect_to :controller => "pages", :action => "home_land"
         cookies[:username]=@gigauser.username
         cookies[:password]=@gigauser.password
         session[:user]=@gigauser.gigaclient_id
          redirect_to clientedit_users_path
       else
          flash[:error]="yet to come"
         redirect_to :controller => "pages", :action => "home_land"
          #render :text => "admin" and return 
      end
  else
     flash[:error]="Invalid user name and password"
     redirect_to :controller => "pages", :action => "home_land"
  end
end
def logout
  session[:user]=nil
  redirect_to :controller => "pages", :action => "home_land"
end
def validate_email
email=params[:email]
if !params[:email].blank?
if email.match(/\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/)
domain = email.match(/\@(.+)/)[1]
      Resolv::DNS.open do |dns|
          @mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
          @a=   dns.getresources(domain,Resolv::DNS::Resource::IN::A)

      end
      if @mx.size > 0 || @a.size > 0 
       @valid="true"
      else
       @valid ="false"
  	end
else
@valid ="false"
end
else
@valid ="false"
end
 def update_profile_client
  @gigauser=Gigaclient.find(session[:user])
  if params[:creditcard]
   @creditcard= ClientcreditDetail.first(:conditions => "gigaclient_id= #{@gigauser.id}")
    if !@creditcard
   @creditcard=ClientcreditDetail.new
   end
  
   @creditcard.expires_on_month=params[:card][:"card_expirty_date(2i)"]
   @creditcard.expires_on_year=params[:card][:"card_expirty_date(1i)"]
   @creditcard.save
   redirect_to :action => "edit_client"
  else
  if @gigauser.update_attributes(params[:gigauser])
#render :text => params.inspect and return
       @gigauser.save
       flash[:success] = "changes have been updated"
    end
    redirect_to :action => "edit_client"
  end

end   



end

def client_billing
@gigauser=Gigaclient.find(session[:user])
@creditcard= ClientcreditDetail.first(:conditions => "gigaclient_id= #{@gigauser.id}")
if !@creditcard
@creditcard=ClientcreditDetail.new
end
  
  respond_to do |format|
		   format.html { render :layout=>'pages_new'   }
		   format.xml  { render :xml => @gigauser }
	
		end
  
end

def update_profile_talent
    @talent = Talent.find(session[:user])
    if @talent.update_attributes(params[:talent])
#render :text => params.inspect and return
       @talent.save
       flash[:success] = "changes have been updated"
    end
    redirect_to :action => "edit_talent"

end
  
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
  
  def talent_registration

# render :text=> params.inspect and return	
		@talent = Talent.new
		
		 #@gigaclient.build_gigadomain
		 respond_to do |format|
		   format.html { render :layout=>'pages_new'   }
		   format.xml  { render :xml => @talent }
	
		end
	        #redirect_to  :controller=>'pages',:action => 'home_land' and return
end
def create_talent_registration
#render :text => params.inspect and return
	@talent=Talent.new(params[:talent])
        if @talent.username
         if !Gigauser.find_by_username(@talent.username)
          @talent.save
           UserMailer.talent_invite(@talent.username, @talent.password, @talent).deliver    
          flash[:alert]='Your profile is created sucessfully'
        redirect_to  :controller=>'pages',:action => 'home_land' 

       else
       flash[:error]='Username already taken'
       redirect_to :action => 'talent_registration'
      end
     else
       @talent.save
       @guser=Gigauser.first(:conditions => "gigaclient_id= #{@talent.id} and role='Talent'")
           UserMailer.talent_invite(@guser.username, @guser.password, @talent).deliver    
          flash[:alert]='Your profile is created sucessfully'
        redirect_to  :controller=>'pages',:action => 'home_land' 
       
    end
	
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
  #@gfind = Gigauser.find(:last)
  @gfind = Gigauser.find_by_sql("SELECT id FROM gigausers order by id DESC limit 1")
	@gigauser = Gigauser.new(params[:gigauser])
	 respond_to do |format|
     #@gigauser.id = @gfind.id.to_i + 1     
     @gigauser.id = @gfind[0]['id'] + 1
		 if @gigauser.save
			 @invite = ClientContactInvite.where(:token => params[:invite_token]).first
			 @invite.update_attribute(:status, 1)
       @invite.recipient.update_attribute(:gigauser_id,@gigauser.id)
       @gigauser.update_attribute(:client_contact_id,@invite.recipient_id)
			 @gigaclient = Gigaclient.find(@gigauser.gigaclient_id)
       UserMailer.registration_details(@gigauser,@gigaclient).deliver
			 format.html { redirect_to "http://#{@gigaclient.gigadomain.subdomain}.#{request.domain}/sign_in", :notice => "Congratulations, you succesfully registered. You can now log in"}
		 else
			@invite = ClientContactInvite.where(:token => params[:invite_token]).first or raise ActiveRecord::RecordNotFound	
			format.html { render :action => "client_user_signup", :layout => 'admin/user_signup'}
		end
       end
end


#### Client User Signup End

  
  #### Client Registration






def client_signup 
 #render :text=> params.inspect and return	
		 @gigaclient = Gigaclient.new
		 @gigaclient.build_gigadomain
		 
		 respond_to do |format|
		   format.html { render :layout=>'pages_new'   }
		   format.xml  { render :xml => @gigaclient }
	
		end	
end







#### Client Registration End



def create_client_registration
 #render :text=> params.inspect and return
 
 #ActiveMerchant::Billing::Base.mode = :test

#gateway = ActiveMerchant::Billing::PaypalGateway.new(
 # :login => "seller_1229899173_biz_api1.railscasts.com",
  # :password => "FXWU58S7KXFC6HBE",
  #:signature => "AGjv6SW.mTiKxtkm6L9DcSUCUgePAUDQ3L-kTdszkPG8mRfjaRZDYtSu"
 #)

#credit_card = ActiveMerchant::Billing::CreditCard.new(
 # :type               => params[:card][:credit_type],
 # :number             => params[:credit_card],
 # :verification_value => params[:verification_number],
 # :month              => params[:card][:"card_expirty_date(2i)"],
 # :year               => params[:card][:"card_expirty_date(1i)"],
 # :first_name         => "Ryan",
 # :last_name          => "Bates"
#)
 
  
 #if credit_card.valid?
  # or gateway.purchase to do both authorize and capture
   #flash[:alert]='Sucessfully created'
  #redirect_to  :controller=>'pages',:action => 'home_land' and return

# response = gateway.authorize(1000, credit_card, :ip => "127.0.0.1",  :billing_address => {
                   
                 # :address1 => "Kakinada",               
             #   :city => "Kakinada",
            #  :state =>"Andhara Pradesh",
            #  :country => "India",
            #  :zip => "533001"
             # })

	 # if response.success?
	 # gateway.capture(10, response.authorization)
	#	flash[:alert]='Sucessfully created'
	 #     redirect_to  :controller=>'pages',:action => 'home_land' and return
	 # else
	  #    flash[:success] = "Error: #{response.message}"
	  #    render :action => 'client_signup', :layout=> 'pages_new' and return
	  #end
  #else
      #flash[:success] = "Error: #{credit_card.errors.full_messages.join(', ')}"
      #render :action => 'client_signup', :layout=> 'pages_new' and return
  #end

#@creditcard=ClientcreditDetail.new
#@creditcard.credit_number=params[:credit_card]
#@creditcard.expires_on_month=params[:card][:"card_expirty_date(2i)"]
#@creditcard.expires_on_year=params[:card][:"card_expirty_date(1i)"]
#@creditcard.verification_number=params[:verification_number]
#@creditcard.card_type= params[:card][:card_type]
#@creditcard.biling_zip=params[:billing_zip]
 
 

 
		if !Gigauser.first(:conditions => "username = '#{params[:gigaclient][:company]}'") 
  		@gigaclient = Gigaclient.new(params[:gigaclient])
		    
    		    respond_to do |format|
		      if @gigaclient.save
                        @guser=Gigauser.first(:conditions => "gigaclient_id= #{@gigaclient.id} and role='Client'")
			#@creditcard.gigaclient_id=@gigaclient.id
			#@creditcard.save
			#~ @gigaclient.gigadomain.update_attribute(:gigaclient_id,  @gigaclient.id)
                       UserMailer.client_invitation(@guser.username, @gigaclient.password, @gigaclient).deliver 

			  flash[:alert]='Your profile is created sucessfully'

  			redirect_to  :controller=>'pages',:action => 'home_land' and return
			format.xml  { render :xml => @gigaclient, :status => :created, :location => @client, :layout=> false  }
		      else
			 render :action => "client_signup", :layout=> 'pages_new' 
			format.xml  { render :xml => @gigaclient.errors, :status => :unprocessable_entity  }
		      end
		    end
        else
		render :action => "client_signup", :layout=> 'pages_new' 
  end
end


  
  
  
  
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
