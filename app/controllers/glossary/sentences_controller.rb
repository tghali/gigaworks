class Glossary::SentencesController < Glossary::GlossaryController
  autocomplete :sentence, :text
  def index
    @sentences = (params[:sentence_search] ? Sentence.search(params[:sentence_search]) : [])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sentences }
    end
  end
  
  def flagged
    @sentences = Sentence.flagged
    respond_to do |format|
      format.html { render :index}
      format.xml  { render :xml => @sentences }
    end
  end
  
  def recent
    @sentences = Sentence.recent
    respond_to do |format|
      format.html { render :index}
      format.xml  { render :xml => @sentences }
    end
  end
  

  # GET /sentences/1
  # GET /sentences/1.xml
  def show
    @sentences = (params[:sentence_search] ? Sentence.search(params[:sentence_search]) : []) 
    @sentence = Sentence.find(params[:id])
    @new_comment = Comment.new
    @new_comment.commentable = @sentence
    @new_tag = Tag.new
    @new_tag.taggable = @sentence
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sentence }
    end
  end

  # GET /sentences/new
  # GET /sentences/new.xml
  def new
    @sentence = Sentence.new
    @sentence.translations.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sentence }
    end
  end

  # GET /sentences/1/edit
  def edit
    @sentences = (params[:sentence_search] ? Sentence.search(params[:sentence_search]) : []) 
    @sentence = Sentence.find(params[:id])
    @sentence.translations.build
  end

  # POST /sentences
  # POST /sentences.xml
  def create
    authorize! :create, Sentence
    
    @sentence = Sentence.find_or_create_with_nested_attributes(params[:sentence].merge :author => current_user)
    
    respond_to do |format|
      if @sentence.save
        format.html { redirect_to(glossary_sentence_path(@sentence), :notice => 'Sentence was successfully created.') }
        format.xml  { render :xml => @sentence, :status => :created, :location => @sentence }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sentence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sentences/1
  # PUT /sentences/1.xml
  def update    
    @sentence = Sentence.find(params[:id])
    
    authorize! :update, @sentence
    
    respond_to do |format|
      if @sentence.update_attributes(params[:sentence].merge :author => current_user)
        format.html { redirect_to(glossary_sentence_path(@sentence,:sentence_search => params[:sentence_search]), :notice => 'Sentence was successfully updated.') }
        format.xml  { head :ok }
      else
        @sentences = (params[:sentence_search] ? Sentence.search(params[:sentence_search]) : [])
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sentence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sentences/1
  # DELETE /sentences/1.xml
  def destroy
    @sentence = Sentence.find(params[:id])
    
    authorize! :destroy, @sentence
    
    @destroyed = @sentence.destroy

    respond_to do |format|
      format.html { redirect_to glossary_sentences_url, :notice => 'Sentence was successfully deleted.' }
      format.xml  { head :ok }
    end
  end
  
  def flag    
    @sentence = Sentence.find(params[:id])
    
    authorize! :flag, @sentence
    
    @sentence.toggle_flag current_user
    
    respond_to do |format|
      if @sentence.save
        format.html { redirect_to(glossary_sentence_path(@sentence), :notice => 'Sentence was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sentence.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end