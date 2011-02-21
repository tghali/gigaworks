class Contacts::OrganisationsController < ApplicationController
  
  def index
    source = can?(:administer, :crm) ? Organisation.scoped : Organisation.shared
    @organisations = load_in_table source, :default_view => 'list' do |tabelle|
      tabelle.filterables %w( name country_code )
      tabelle.sortables %w( first_name last_name created_at updated_at)
      tabelle.load_per_page :list => 28, :grid => 24
    end
  end
  
  # GET /organisations/1
  # GET /organisations/1.xml
  def show

    @organisation = Organisation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @organisation }
    end
  end

  # GET /organisations/new
  # GET /organisations/new.xml
  def new
    @organisation = Organisation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @organisation }
    end
  end

  # GET /organisations/1/edit
  def edit
    @organisation = Organisation.find(params[:id])
    
  end

  # POST /organisations
  # POST /organisations.xml
  def create
    @organisation = Organisation.find_or_create_with_nested_attributes(params[:organisation])
    
    respond_to do |format|
      if @organisation && @organisation.save
        format.html { redirect_to(glossary_organisation_path(@organisation), :notice => 'Organisation was successfully created.') }
        format.xml  { render :xml => @organisation, :status => :created, :location => @organisation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @organisation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /organisations/1
  # PUT /organisations/1.xml
  def update
    @organisation = Organisation.find(params[:id])

    respond_to do |format|
      if @organisation.update_attributes(params[:organisation])
        format.html { redirect_to(glossary_organisation_path(@organisation), :notice => 'Organisation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @organisation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /organisations/1
  # DELETE /organisations/1.xml
  def destroy
    @organisation = Organisation.find(params[:id])
    @organisation.destroy

    respond_to do |format|
      format.html { redirect_to glossary_organisations_url, :notice => 'Organisation was successfully deleted.' }
      format.xml  { head :ok }
    end
  end
  
  
  
end
