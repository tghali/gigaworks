class Schedule::ScheduleController < ApplicationController
	 layout 'admin/gigaclient'
  def show
   redirect_to :action => 'dashboard'
 end
 
 def dashboard
   
  end
  
  def glossary	
 
	  if params[:search]
	    @sentences =  Sentence.find(:all,:conditions => ["text LIKE ? ","%#{params[:search]}%"]).paginate :page => params[:page],:per_page => 20, :order => 'created_at DESC'  
	  
         else
	    @sentences = Sentence.order("created_at").page(params[:page]).per(4)	
	    
	 end   

	    respond_to do |format|
	      format.html # index.html.erb
	      format.js
	      format.xml  { render :xml => @sentences }
	    end
  end
    
  def search

	  @sentences =  Sentence.where("text LIKE ? ","#{params[:letter]}%").order("created_at").page(params[:page]).per(4)
	  

	  
	   respond_to do |format|
	      format.js # index.html.erb
	      format.xml  { render :xml => @sentences }
	   end
  end	  
 
end
