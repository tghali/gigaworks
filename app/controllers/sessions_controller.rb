class SessionsController < ApplicationController
  
  def new
    current_session.signout if current_session.signed_in?
    render :action => "new", :status => :unauthorized if flash[:error]
  end
  
  def create
    user = User.authenticate(params[:session][:email_or_username], params[:session][:password])
    if user
      if user.verified?
        Rails.logger.info "user #{user.name} signed in succesfuly"
        current_session.user_id = user.id
        current_session.remember_me! if params[:session][:remember_me]
        redirect_to previous_page_or_home
      else
        flash.now[:error] = t(:'account.must_verify')
        Rails.logger.info "user #{user.name} couldn't log - not verified"
        render :action => "new", :status => :unauthorized
      end
    else 
      flash.now[:error] = t(:'account.wrong_password')
      Rails.logger.info "ip #{request.env['REMOTE_ADDR']} tried to log in as #{params[:session][:email_or_username]}"
      render :action => "new", :status => :unauthorized
    end 
  end
  
  def destroy
    if current_session.signed_in?
      current_session.signout
      redirect_to sign_in_path
    else
      flash.now[:error] = t(:'account.not_logged_in_yet')
      redirect_to sign_in_path
    end
  end
end
