class Documents::DocumentsController < ApplicationController
  
  def index
    #~ render :layout => false
    #~ @source_documents = SourceDocument.find(:all)
    @source_documents = SourceDocument.find(:all)
    @document = Document.find(:first,:conditions => "source_document_id = 1")

     respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @source_documents }
    end
    
  end
  
  def show   
  end
  
  #GET method
  def new
    @source_document = SourceDocument.find(params[:folder_id])
    @document = Document.new
     respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @document }
    end
  end
  
   # POST /documents
  # POST /documents.xml
  def create
    @document = Document.new(params[:document])
    
    authorize! :create, Document
    
    @document.author_id = current_user.id
    
    respond_to do |format|
      if @document.save
        format.html { redirect_to(document_path(@document), :notice => 'Document was successfully uploaded.') }
        format.xml  { render :xml => @document, :status => :created, :location => @document }
      else
        @source_document = SourceDocument.find(params[:folder_id])
        format.html { render :action => "new" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /document/1
  #~ def destroy
    #~ authorize! :destroy, Document
    
    #~ @document = Document.find(params[:id])
    #~ render :text => "sdfs" and return
    #~ @document.destroy

    #~ respond_to do |format|
      #~ format.html { redirect_to documents_path, :notice => 'Contact was successfully deleted.' }
      #~ format.xml  { head :ok }
    #~ end
  #~ end
   #~ def source_document
     #~ @source_document = SourceDocument.new
     #~ respond_to do |format|
      #~ format.html # new.html.erb
      #~ format.xml  { render :xml => @source_document }
    #~ end
  #~ end
  
   #~ # POST /documents.xml
  #~ def create_source_document
    #~ @source_document = SourceDocument.new(params[:document])    
    #~ authorize! :create, SourceDocument   
    
    
    #~ respond_to do |format|
      #~ if @source_document.save
        #~ format.html { redirect_to(documents_path, :notice => 'Source Document was successfully created.') }
        #~ format.xml  { render :xml => @source_document, :status => :created, :location => @source_document }
      #~ else
        #~ format.html { render :action => "source_document" }
        #~ format.xml  { render :xml => @source_document.errors, :status => :unprocessable_entity }
      #~ end
    #~ end
  #~ end
  
  
  
  
 def document_download  
   document = Document.find(params[:id])      
      #~ render :text => File.exists?("#{RAILS_ROOT}/public/system/documents/#{params[:id]}/original/#{document.document_file_name}") and return
    
      if document 
        respond_to do |format|
            if File.exists?("#{RAILS_ROOT}/public/system/documents/#{params[:id]}/original/#{document.document_file_name}")
              #~ render :text => "#{RAILS_ROOT}/public/system/documents/#{params[:id]}/original/#{document.document_file_name}" and return
              send_file "#{RAILS_ROOT}/public/system/documents/#{params[:id]}/original/#{document.document_file_name}"
            else
              #~ flash[:msg] = "File doesn't exist.Unable to download the file."
              format.html { redirect_to(documents_path,:notice => "File doesn't exist.Unable to download the file.") }
            end
        end
      end
    end

  
end
