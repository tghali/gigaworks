class Glossary::TranslationPairsController < Glossary::GlossaryController
  
  def new
    @sentence = Sentence.find(params[:sentence_id])

    @translation = @sentence.translations.build

    
    respond_to do |format|
      format.html
      format.js
      # format.xml  { render :xml => @word }
    end
  end


  def edit
    @sentences = (params[:sentence_search] ? Sentence.search(params[:sentence_search]) : [])  
    @translation = TranslationPair.find(params[:id])    
    @sentence    = @translation.source
  end


  def create
    authorize! :create, Translation
    
    @sentence = Sentence.find(params[:sentence_id])
    @translation = @sentence.translations.build(params[:translation_pair])
    
    respond_to do |format|
      if @sentence.save
        format.html { redirect_to(glossary_sentence_path(@sentence,:sentence_search => params[:sentence_search]), :notice => 'The translation was added successfully.') }
        # format.xml  { render :xml => @word, :status => :created, :location => @word }
      else
        @sentences = (params[:sentence_search] ? Sentence.search(params[:sentence_search]) : [])
        format.html { render :new }
        # format.xml  { render :xml => @word.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @translation = TranslationPair.find(params[:id])
    
    authorize! :update, @translation
    
    respond_to do |format|
      if @translation.update_attributes(params[:translation_pair])
        format.html { redirect_to(glossary_sentence_path(@translation.source), :notice => 'The translation was successfully updated.') }
        # format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        # format.xml  { render :xml => @word.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @sentence = Sentence.find(params[:sentence_id])
    translation = TranslationPair.find(params[:id])
    
    authorize! :destroy, translation
    
    translation.destroy
    respond_to do |format|
      format.html { redirect_to glossary_sentence_path(@sentence,:sentence_search => params[:sentence_search]), :notice => 'The translation was successfully deleted.' }
      # format.xml  { head :ok }
    end
  end
  
end
