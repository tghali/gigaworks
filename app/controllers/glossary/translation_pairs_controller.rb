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
    @translation = TranslationPair.find(params[:id])
    
    @sentence    = @translation.source
  end


  def create
    @sentence = Sentence.find(params[:sentence_id])
    @translation = @sentence.translations.build(params[:translation_pair])
    
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
      if @translation.update_attributes(params[:sentence])
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
    
    translation.destroy
    respond_to do |format|
      format.html { redirect_to glossary_sentences_path, :notice => 'The translation was successfully deleted.' }
      # format.xml  { head :ok }
    end
  end
  
end