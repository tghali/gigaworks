class Documents::SourceDocumentController < ApplicationController
  
  def index
  end
  
  def show    
  end
  
  def new
       @source_document = SourceDocument.new
         respond_to do |format|
           format.js
          format.html # new.html.erb
          #~ format.xml  { render :xml => @source_document }
        end
  end
      
  def create  
    @source_document = SourceDocument.new(params[:source_document])    
    authorize! :create, SourceDocument      
    @source_document.author_id = current_user.id
    respond_to do |format|
      if @source_document.save
        format.html { redirect_to(documents_path, :notice => 'Assignment was successfully created.') }
        format.xml  { render :xml => @source_document, :status => :created, :location => @source_document }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @source_document.errors, :status => :unprocessable_entity }
      end
    end
    
  end
  
  
    # DELETE /assignment/1.xml
  def destroy
    @source_document = SourceDocument.find(params[:id])    
    authorize! :destroy, @source_document    
    @destroyed = @source_document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, :notice => 'Assignment was successfully deleted.' }
      format.xml  { head :ok }
    end
  end 
  
  
  
end
