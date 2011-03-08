class PasswordsController < ApplicationController
  before_filter :ensure_user_is_not_signed_in
  
  # forgot
  def new
    @user = User.new
  end
  
  # Create a new password reset
  def create
    begin
      @user = User.forgot_password_for(params[:user][:email])
      if @user.save
        UserMailer.password_reset(@user).deliver
        flash[:success] = t:'account.password_reset_code_sent'
        redirect_to sign_in_url
      else
        flash[:error] = t:'account.password_reset_error'
        render :new, :status => :internal_error
      end
    rescue ActiveRecord::RecordNotFound
      @user = User.new
      @user.errors.add :email, ": No active user has that email."
      render :new, :status => :not_found
    end
  end
  
  # Change password
  def edit
    @user = User.find_by_password_reset_token(params[:password_reset_token] || 'notoken')
    case @user
    when @user.nil? then
      flash[:error] = t:'account.password_reset_code_not_valid'
      @user = User.new
      render :action => 'new', :status => :forbidden
    when @user.password_reset_key then
      flash[:error] = t:'account.password_reset_code_expired'
      render :action => 'new', :status => :forbidden
    end
  end
  
  # Resets the password
  def update
    @user = User.find_by_password_reset_token(params[:user][:password_reset_token])
    unless @user
      flash[:error] = t:'account.password_reset_code_not_valid'
      redirect_to :action => 'new'
    else
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      respond_to do |format|
        if @user.save
          flash[:notice] = t:'accont.password_updated'
          current_session.user_id = @user.id
          current_session.remember! if params[:remember_me]
          format.html { redirect_to account_path }
          format.xml  { head :ok }
        else
          format.html { render :edit }
          format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

end