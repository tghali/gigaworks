class Schedule::ScheduleController < ApplicationController
	 layout 'admin/gigaclient'
    autocomplete :sentence, :text	
   before_filter :tags_count, :authenticate
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
    authorize! :add_flag, Sentence  
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
    authorize! :tag_delete, Sentence  
       @tag = Tag.find(params[:tag_id])       
  respond_to do |format|
	      if @tag.destroy
		      
             if params[:id]      
               @sentences = Sentence.flagged.order("created_at").page(params[:page]).per(25)	
            else
              @sentences = Sentence.order("created_at").page(params[:page]).per(25)
            end   
     tags_count            
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
    authorize! :create_sentence, Sentence
    @sentence = Sentence.find_or_create_with_nested_attributes(params[:sentence].merge :author => current_user)
    @sentence.author_id = current_user.id
    @sentence.comment = params[:sentence][:comment]
    @sentence.description = params[:sentence][:description]
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
     authorize! :update_sentence, Sentence
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
	  #~ @sentences = Sentence.recent.order("created_at DESC").page(params[:page]).per(25)
    @glossary_actions = GlossaryAction.order("created_at DESC").page(params[:page]).per(25)
	    respond_to do |format|
	      format.js
	      format.xml  { render :xml => @glossary_actions }
	    end
  end

  def delete_sentence
     authorize! :delete_sentence, Sentence
    @sentence = Sentence.find(params[:id])    
    #~ authorize! :destroy, @sentence    
    @destroyed = @sentence.destroy
    respond_to do |format|
      tags_count
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
	     @sentences = Sentence.order("created_at").page(params[:page]).per(25) 
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
    tags_count
		format.js { render :sentence_update }
		format.xml  { head :ok  }
      else
        # TODO: ensure that if the tag form has errors it displays them and it is opened at page load
        format.html { redirect_to :action => :glossary}
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end

 end


 def comment_delete
  authorize! :comment_delete, Comment  
 @sentence = Sentence.find(params[:sid])		 
 @comment = Comment.find_by_id(params[:cid])       
  respond_to do |format|
	      if @comment.destroy		      
	       @sentences = Sentence.order("created_at").page(params[:page]).per(25)
		format.js {render :comments }
		format.xml  { head :ok  }
	    end
   end
 end
 
  def delete_translation
  authorize! :delete_translation, Sentence  
  @sentence = Sentence.find(params[:sid])		 
  @translation = TranslationPair.find_by_id(params[:tid])    
  respond_to do |format|
	      if @translation.destroy		      
	       @sentences = Sentence.order("created_at").page(params[:page]).per(25)
		format.js {render :edit_sentence }
		format.xml  { head :ok  }
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
