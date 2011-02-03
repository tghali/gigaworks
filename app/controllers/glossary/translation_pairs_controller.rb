class Glossary::TranslationPairsController < Glossary::GlossaryController
  before_filter :load_sentences
  
  def new
    @sentence = Sentence.find(params[:sentence_id])

    @translation = @sentence.translations.build

    
    respond_to do |format|
      format.html
      # format.xml  { render :xml => @word }
    end
  end


  def edit
    translation = TranslationPairs.find(params[:id])
    
    @sentence    = translation.source
    @translation = translation.result
    
    render :new
  end


  def create
    @sentence = Sentence.find(params[:sentence_id])
    @translation = @sentence.translations.build(params[:sentence])
    
    respond_to do |format|
      if @sentence.save
        format.html { redirect_to(glossary_sentence_path(@sentence), :notice => 'The translation was added successfully.') }
        # format.xml  { render :xml => @word, :status => :created, :location => @word }
      else
        format.html { render :new }
        # format.xml  { render :xml => @word.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @translation = TranslationPair.find(params[:id])
    
    respond_to do |format|
      if @translation.result.update_attributes(params[:sentence])
        format.html { redirect_to(glossary_sentence_path(@translation.source), :notice => 'The translation was successfully updated.') }
        # format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        # format.xml  { render :xml => @word.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    translation = TranslationPair.find(params[:id])
    
    Translation.transaction do
      translation.word.destroy if translation.word.definitions.empty?
      translation.destroy
    end
    respond_to do |format|
      format.html { redirect_to(words_url) }
      # format.xml  { head :ok }
    end
  end
  
end
