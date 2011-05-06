require 'net/ftp'
require 'tempfile'


class Documents::DocumentsController < ApplicationController
  
  def index
    #~ render :layout => false
    #~ @source_documents = SourceDocument.find(:all)
    @source_documents = SourceDocument.find(:all)
    #~ @document = Document.find(:first,:conditions => "source_document_id = 1")

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
       format.js
      #~ format.html # new.html.erb
      #~ format.xml  { render :xml => @document }
    end
  end
  
   # POST /documents
  # POST /documents.xml
  def create
    @source_document = SourceDocument.find(params[:folder_id])
    @document = Document.new(params[:document])    
    authorize! :create, Document    
    @document.author_id = current_user.id 
 



    respond_to do |format|
      if @document.save
        format.html { redirect_to(documents_path, :notice => 'Document was successfully uploaded.') }
        format.xml  { render :xml => @document, :status => :created, :location => @document }
      else
        @source_document = SourceDocument.find(params[:folder_id])
        format.html { render :action => "new" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /document/1
  def destroy
    #~ authorize! :destroy, Document    
    @document = Document.find(params[:id])  
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_path, :notice => 'Document was successfully deleted.' }
      format.xml  { head :ok }
    end
  end
  
  
   def show_information   

     @document = Document.find(params[:id])
     respond_to do |format|
      #~ format.html
      format.js
    end
  end
  
 
  
 def document_download  
   document = Document.find(params[:id])      
      #~ render :text => File.exists?("#{RAILS_ROOT}/public/system/documents/#{params[:id]}/original/#{document.document_file_name}") and return
    
          if document       
                if File.exists?("#{RAILS_ROOT}/public/mydocuments/#{params[:id]}/original_#{document.document_file_name}")             
                  send_file "#{RAILS_ROOT}/public/mydocuments/#{params[:id]}/original_#{document.document_file_name}"
                end
          else
            redirect_to documents_path
          end
    end

  
end
