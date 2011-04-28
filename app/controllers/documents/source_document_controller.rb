class Documents::SourceDocumentController < ApplicationController
  
  def index
  end
  
  def show
    
  end
  
  def new
       @source_document = SourceDocument.new
         respond_to do |format|
          format.html # new.html.erb
          format.xml  { render :xml => @source_document }
        end
  end
      
  def create    
    @source_document = SourceDocument.new(params[:source_document])    
    authorize! :create, SourceDocument      
    @source_document.author_id = current_user.id
    respond_to do |format|
      if @source_document.save
        format.html { redirect_to(documents_path, :notice => 'Source Document was successfully created.') }
        format.xml  { render :xml => @source_document, :status => :created, :location => @source_document }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @source_document.errors, :status => :unprocessable_entity }
      end
    end
    
  end
  
end
