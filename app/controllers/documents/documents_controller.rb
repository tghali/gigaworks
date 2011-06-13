require 'net/ftp'
require 'tempfile'


class Documents::DocumentsController < ApplicationController
  
  def index
    #~ @source_documents = SourceDocument.find(:all,:conditions => "author_id = #{current_user.id}")
    @source_documents = SourceDocument.find(:all)

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
  begin
   document = Document.find(params[:id])      
      #~ render :text => File.exists?("#{RAILS_ROOT}/public/system/documents/#{params[:id]}/original/#{document.document_file_name}") and return
    
		  if document	  
			  data = open(document.document.url(:original)).read
			  send_data data, :filename => document.document.original_filename 		
		  else
			redirect_to documents_path
		 end
  	 rescue
		redirect_to documents_path
	 end
    end


 def view_document
	begin 
	 document = Document.find(params[:id])      
	 if document
		 redirect_to document.document.url
	 end
	 rescue
		redirect_to documents_path
	 end
 end

 def multi_file_upload
	  @source_document = SourceDocument.find(params[:folder_id])
	 @document = Document.new
	     respond_to do |format|
		format.html     
	    end
  end

def multifile_create
	begin
  puts "-------multifile_create  #{params.inspect}"
	params[:document].each_with_index do |doc,i|
		Document.create(:author_id => current_user.id, :first_name => params[:document][:first_name], :last_name => params[:document][:last_name], :source_document_id=> params[:document][:source_document_id],:document => params[:document][:document][i])
	end
	   redirect_to(documents_path, :notice => 'Documents was successfully uploaded.') 
	rescue		
		redirect_to(documents_path, :notice => 'Something went wrong while uploading files. Please try again') 
	end
	
end




  
end
