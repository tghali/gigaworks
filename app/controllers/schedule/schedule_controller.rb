class Schedule::ScheduleController < ApplicationController
	 layout 'admin/gigaclient'
    autocomplete :sentence, :text	
   before_filter :tags_count
  def show
   redirect_to :action => 'dashboard'
 end
 
 def dashboard
   
  end
  
  def glossary 
	  if params[:id]
		   @sentences = Sentence.flagged.order("created_at").page(params[:page]).per(25)	  
    elsif params[:text_search]
		   @sentences = Sentence.where("text ILIKE ? ","%#{params[:text_search]}%").page(params[:page]).per(25)	
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
   
       def tagsearch
     
  	    @sentences =  Sentence.where("tags.tag LIKE ? AND tags.taggable_type = 'Sentence'","#{params[:letter]}").joins(:tags).order("created_at DESC").page(params[:page]).per(25)   

	  
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
 
 def new_sentence
    @sentence = Sentence.new
    @sentence.translations.build 
    respond_to do |format|
	     format.js
	     format.xml  { render :xml => @sentence }
    end
 end
 
 
 def create_sentence
    @sentence = Sentence.find_or_create_with_nested_attributes(params[:sentence].merge :author => current_user)
    @sentence.author_id = current_user.id
    respond_to do |format|
      if @sentence.save
	@sentences = Sentence.order("created_at DESC").page(params[:page]).per(25)
        format.js { render :glossary }
        format.xml  { render :xml => @sentence, :status => :created, :location => @sentence }
     else	     
	     format.js { render :action => :new_sentence }
	     format.xml  { render :xml => @sentence.errors, :status => :unprocessable_entity }
      end
    end

  end 

def edit_sentence
	@sentence = Sentence.find(params[:sid])
	    if @sentence.translations.blank?
    @sentence.translations.build 
    end
	   respond_to do |format|
	      format.js # index.html.erb
	      format.xml  { render :xml => @sentence }
	   end
        
end

def update_sentence
    @sentence = Sentence.find(params[:sid])   
    @sentence.comment = params[:sentence][:comment]
    @sentence.description = params[:sentence][:description]
    respond_to do |format|
	      if @sentence.update_attributes!(params[:sentence].merge :author => current_user)
		format.js { render :sentence_update }
		format.xml  { head :ok  }
	      end
    end
end


  def recent_activity
	  @sentences = Sentence.recent.order("created_at DESC").page(params[:page]).per(25)	    
    respond_to do |format|
      format.js { render :glossary}
      format.xml  { render :xml => @sentences }
    end
  end

  def delete_sentence
    @sentence = Sentence.find(params[:id])    
    #~ authorize! :destroy, @sentence    
    @destroyed = @sentence.destroy
    respond_to do |format|
      @sentences = Sentence.order("created_at").page(params[:page]).per(25)
      format.js {  render :glossary}
      format.xml  { head :ok }
    end
  end

  def comments
   @sentence = Sentence.find(params[:sid])
    respond_to do |format|
      format.js
      format.xml  { head :ok }
    end	
end

def create_comment
    @sentence = Sentence.find(params[:sid])
    @comment = @sentence.comments.build(params[:comment])
    @comment.author_id = current_user.id    

    respond_to do |format|
      if @comment.save	
	      
		format.js {render :comments }
		format.xml  { head :ok  }
      else
        # TODO: ensure that if the tag form has errors it displays them and it is opened at page load
        format.html { redirect_to :action => :glossary}
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end

end

def new_tag
 @sentence = Sentence.find(params[:sid])
    respond_to do |format|
      format.js
      format.xml  { head :ok }
    end	
end
 
 def create_tag
    @sentence = Sentence.find(params[:sid])
    @tag = @sentence.tags.build(params[:tag])
       #~ authorize! :create, @tag
    
    respond_to do |format|
      if @tag.save	

		format.js { render :sentence_update }
		format.xml  { head :ok  }
      else
        # TODO: ensure that if the tag form has errors it displays them and it is opened at page load
        format.html { redirect_to :action => :glossary}
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end

 end

 
 
protected
 
 def tags_count
	 @tags = Tag.select("tag").group(:tag).count
	 #~ for t in @tags
	 #~ render :text =>  t[1]and return
	 #~ end
 end
 
end
