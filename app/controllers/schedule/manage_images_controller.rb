class Schedule::ManageImagesController < ApplicationController
   layout 'admin/gigaclient'
   before_filter :authenticate	 		 
  def index   
	    @manage_images = ManageImage.order("created_at").page(params[:page]).per(4)  
	     respond_to do |format|
	      format.html 
	      format.js
	      format.xml  { render :xml => @manage_images }
	    end
  end
  
end
