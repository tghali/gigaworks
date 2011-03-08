class Contacts::ContactsController < ApplicationController
  
  def index
    source = can?(:administer, :crm) ? Contact.scoped : Contact.shared
    @contacts = load_in_table source, :default_view => 'list' do |tabelle|
      tabelle.filterables %w( first_name last_name )
      tabelle.sortables %w( first_name last_name created_at updated_at)
      tabelle.load_per_page :list => 28, :grid => 24
    end
  end
  
  # GET /contacts/1
  # GET /contacts/1.xml
  def show

    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @contact = Contact.new
    @contact.addresses.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
    
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = Contact.new(params[:contact])
    authorize! :create, Contact
    
    respond_to do |format|
      if @contact.save
        format.html { redirect_to(contact_path(@contact), :notice => 'Contact was successfully created.') }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = Contact.find(params[:id])
    authorize! :update, Contact
    
    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to(contact_path(@contact), :notice => 'Contact was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    authorize! :destroy, Contact
    
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url, :notice => 'Contact was successfully deleted.' }
      format.xml  { head :ok }
    end
  end
  
  # POST /contacts/1/invite
  def invite
    authorize! :invite, Contact
    
    @contact = Contact.find(params[:id])
    @invite = @contact.build_invite(:sender => current_user)
    
    respond_to do |format|
      if @invite.save
        UserMailer.invite(@invite).deliver
        format.html { redirect_to(contact_path(@contact), :notice => 'Contact was successfully invited.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "invite" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
