class Schedule::ManageImagesController < ApplicationController
   layout 'admin/gigaclient'
   before_filter :authenticate	 		 
  def index
		   @manage_images = ManageImage.all	  
	     respond_to do |format|
	      format.html 
	      format.xml  { render :xml => @manage_images }
	    end
  end
  
end
