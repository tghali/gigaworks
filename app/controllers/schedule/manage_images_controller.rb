class Schedule::ManageImagesController < ApplicationController
   layout 'admin/gigaclient'
   before_filter :authenticate	 		 
  def index   
	    @manage_images = ManageImage.order("created_at").page(params[:page]).per(12)  
	     respond_to do |format|
	      format.html 
	      format.js
	      format.xml  { render :xml => @manage_images }
	    end
    end
    
    def new
    @manage_image = ManageImage.new
    respond_to do |format|
	     format.js
	     format.xml  { render :xml => @manage_image }
    end
 end
 
 
 def create	
    authorize! :create, ManageImage
    @manage_image = ManageImage.new(params[:manage_image])
    respond_to do |format|
      if @manage_image.save
        format.html {redirect_to images_list_url }
        format.xml  { render :xml => @manage_image, :status => :created, :location => @manage_image }
     else	     
	     format.js { render :action => :new }
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
      if @manage_image.update_attributes(params[:manage_image])
	 format.html { redirect_to(images_list_path, :notice => 'Image has been successfully updated.') }
         format.xml  { render :xml => @manage_image, :status => :created, :location => @manage_image }
      else   
        format.js { render :edit }
        format.xml  { render :xml => @manage_image.errors, :status => :unprocessable_entity }
      end
    end
  end
  
 def download_image  
  begin
   download_image = ManageImage.find(params[:id])    
		  if download_image	  
			  data = open(download_image.image.url(:original)).read
			  send_data data, :filename => download_image.image.original_filename 		
		  else
			redirect_to images_list_path,:notice => "The image not found with this id."		
		 end
  	 rescue
	       
		redirect_to images_list_path,:notice => "There is a problem to download the image."
	 end
    end
  
  
  
    
  def destroy
     authorize! :destroy, ManageImage  
    @manage_image = ManageImage.find(params[:id])     
    @manage_image.destroy    
    respond_to do |format|
	 @manage_images = ManageImage.order("created_at").page(params[:page]).per(12)  
      format.js {render :list_of_images}	    
      #format.html { redirect_to images_list_path, :notice => 'Image was successfully deleted.' }
      format.xml  {  render :xml => @manage_image }
    end
  end	  
  
end
