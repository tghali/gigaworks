class Admin::UsersController < Admin::AdminController
  
  def index
    @users = load_in_table User, :default_view => 'list' do |tabelle|
      tabelle.filterables %w( user_name )
      tabelle.sortables %w( user_name created_at updated_at)
      tabelle.load_per_page :list => 28, :grid => 24
    end
    
  end
  
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
    @user = User.find(params[:id])
    begin
      @user.verified!
    rescue
      respond_to do |format|
        format.html {redirect_to admin_users, :error => @user.verification_key.errors.on(:base)}
      end
    end
  end
  
  def destroy
    user = User.find(params[:id])
    
    translation.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url, :notice => 'The user was successfully deleted.' }
      # format.xml  { head :ok }
    end
  end
  
end