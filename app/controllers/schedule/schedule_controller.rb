class Schedule::ScheduleController < ApplicationController
	 layout 'admin/gigaclient'
  def show
   redirect_to :action => 'dashboard'
 end
 
 def dashboard
   
  end
  
  def glossary 
	  if params[:id]
		   @sentences = Sentence.flagged.order("created_at").page(params[:page]).per(25)	  
         else
	    @sentences = Sentence.order("created_at").page(params[:page]).per(25)		    
	 end   

	    respond_to do |format|
	      format.html # index.html.erb
	      format.js
	      format.xml  { render :xml => @sentences }
	    end
  end
    
  def search
      if params[:id]	
	      @sentences = Sentence.flagged.where("text ILIKE ? ","#{params[:letter]}%").order("created_at").page(params[:page]).per(25)	  
      else	     
  	    @sentences =  Sentence.where("text ILIKE ? ","#{params[:letter]}%").order("created_at").page(params[:page]).per(25)   
       end
	  
	   respond_to do |format|
	      format.js # index.html.erb
	      format.xml  { render :xml => @sentences }
	   end
   end	
   
  def add_flag	  
    @sentence = Sentence.find(params[:sid])  
    @sentence.client_toggle_flag(current_user)    
    respond_to do |format|
	      if @sentence.save
		 if params[:id]      
			 @sentences = Sentence.flagged.order("created_at").page(params[:page]).per(25)	
		else
			@sentences = Sentence.order("created_at").page(params[:page]).per(25)
		end
		 format.js  
		 format.xml  { head :ok }
	    end
   end
 end
 
 def tag_delete
       @tag = Tag.find(params[:tag_id])       
  respond_to do |format|
	      if @tag.destroy
		      
             if params[:id]      
               @sentences = Sentence.flagged.order("created_at").page(params[:page]).per(25)	
            else
              @sentences = Sentence.order("created_at").page(params[:page]).per(25)
            end     
		 format.js  
		 format.xml  { head :ok }
	    end
   end
 end 

 
end
