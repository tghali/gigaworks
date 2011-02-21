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
    @contact = Contact.find_or_create_with_nested_attributes(params[:contact])
    
    respond_to do |format|
      if @contact && @contact.save
        format.html { redirect_to(glossary_contact_path(@contact), :notice => 'Contact was successfully created.') }
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

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to(glossary_contact_path(@contact), :notice => 'Contact was successfully updated.') }
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
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to glossary_contacts_url, :notice => 'Contact was successfully deleted.' }
      format.xml  { head :ok }
    end
  end
  
end
