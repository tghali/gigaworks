class Admin::UsersController < AdminController
  
  def new
    @user = params[:contact_id] ? Contact.find(params[:contact_id]).build_user : User.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @word }
    end
  end
  
  def edit
    @user = User.find(params[:id])
    
    @user.password = nil
    @user.password_confirmation = nil
  end
  
  def create
    @user = User.new(params[:user])
    @user.status = :verified
    
    respond_to do |format|
      if @user.save 
        format.html { redirect_to admin_users, :notice => 'User succesfully created' }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end      
    end
  end
  
  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      flash[:success] = 'The user profile was updated.'
      render :action => 'edit'
    else
      render :action => 'edit'
    end
  end
  
  # TODO: create a landing page for email account verification
  def verify
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