class Images::ManageImagesController < ApplicationController
	
	 def index    
		@manage_images = ManageImage.paginate :page => params[:page], :order => 'created_at DESC'	  
	     respond_to do |format|
	      format.html 
	      format.xml  { render :xml => @manage_images }
	    end
       end
    
      def new
       @manage_image = ManageImage.new
         respond_to do |format|
           format.js
          format.html # new.html.erb 
        end
	end

  def create  
    @manage_image = ManageImage.new(params[:manage_image])    
    authorize! :create, ManageImage      
    @manage_image.author_id = current_user.id
    respond_to do |format|
      if @manage_image.save
         format.html { redirect_to(manage_images_path, :notice => 'Image has been successfully uploaded.') }
         format.xml  { render :xml => @manage_image, :status => :created, :location => @upload_image }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @manage_image.errors, :status => :unprocessable_entity }
      end
    end
    
  end

	def edit 
		@manage_image = ManageImage.find(params[:id])
		respond_to do |format|
		   format.js
		  format.html # new.html.erb 
		end
	end
  
    def update    
    @manage_image = ManageImage.find(params[:id])
    
    authorize! :update, @manage_image
    
    respond_to do |format|
      if @manage_image.update_attributes(params[:manage_image].merge :author => current_user)
	 format.html { redirect_to(manage_images_path, :notice => 'Image has been successfully updated.') }
         format.xml  { render :xml => @manage_image, :status => :created, :location => @manage_image }
      else   
        format.html { render :action => "edit" }
        format.xml  { render :xml => @manage_image.errors, :status => :unprocessable_entity }
      end
    end
  end




   def show
	@manage_image = ManageImage.find(params[:id])
         respond_to do |format|
           format.js
           format.html # new.html.erb         
        end

  end

   # DELETE /image/1
  def destroy
   authorize! :destroy, ManageImage  
    @manage_image = ManageImage.find(params[:id])     
    @manage_image.destroy    
    respond_to do |format|
      format.html { redirect_to manage_images_path, :notice => 'Image Management record was successfully deleted.' }
      format.xml  { head :ok }
    end
  end


def download_image  
  begin
   uploadimage = ManageImage.find(params[:id])      
      #~ render :text => File.exists?("#{RAILS_ROOT}/public/system/documents/#{params[:id]}/original/#{document.document_file_name}") and return
    
		  if uploadimage	  
			  data = open(uploadimage.image.url(:original)).read
			  send_data data, :filename => uploadimage.image.original_filename 		
		  else
			redirect_to manage_images_path
		 end
  	 rescue
		redirect_to manage_images_path
	 end
    end

  def view_uploadimage
	begin 
	 uploadimage = ManageImage.find(params[:id])      
	 if uploadimage
		 redirect_to uploadimage.image.url
	 end
	 rescue
		redirect_to manage_images_path
	 end
 end

    def my_search_logic(str)
	     return [],[],[] if str.blank?
	     cond_text   = str.split.map{|w| "tags LIKE ? "}.join(" OR ")
	   
	     cond_values = str.split.map{|w| "%#{w}%"}
	     return str,cond_text,cond_values
    end


def search
	
	
	if !params[:search].blank?
		str,cond_text,cond_values = my_search_logic(params[:search])
		puts "#{str}, --#{cond_text},----#{cond_values}"
		#~ @find_images = ManageImage.paginate :page => params[:page], :conditions => ["subject LIKE ?", "%#{params[:search]}%"] \
		#~ |       ManageImage.search(my_search_logic(params[:search]))#.paginate :page => params[:page] #ManageImage.tagged_with("%#{params[:search]}%") 

		@find_images =  ManageImage.search(str,cond_text,cond_values).paginate :page => params[:page]  #ManageImage.tagged_with("%#{params[:search]}%") 



	     if params[:search] == 'Enter keyword'
		     @msg = 'Please enter any tag to search'
	     end	      
	     respond_to do |format|		     
	      format.js 
	      format.xml  { render :xml => @find_images }
	    end
	end
	
end

    
end
