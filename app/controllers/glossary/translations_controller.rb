class Glossary::TranslationsController < Glossary::GlossaryController
  
  before_filter :load_words
  
  def new
    @definition = Definition.find(params[:definition_id])

    @translation = @definition.translated_words.build

    
    respond_to do |format|
      format.html
      # format.xml  { render :xml => @word }
    end
  end


  def edit
    translation = Translation.find(params[:id])
    
    @definition =  translation.definition
    @translation = translation.word
    
    render :new
  end


  def create
    @definition = Definition.find(params[:definition_id])
    @translation = @definition.add_translation(params[:word])
    
    respond_to do |format|
      if @translation.save
        format.html { redirect_to(glossary_word_path(@definition.word), :notice => 'The translation was added successfully.') }
        # format.xml  { render :xml => @word, :status => :created, :location => @word }
      else
        format.html { render :new }
        # format.xml  { render :xml => @word.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @translation = Translation.find(params[:id])
    old_word = @translation.word
    
    @translation.word = Word.where(params[:word]) || Word.create(params[:word])
    
    respond_to do |format|
      if @translation.save
        old_word.destroy if old_word.definition.empty?
        format.html { redirect_to(glossary_word_path(@definition.word), :notice => 'The translation was successfully updated.') }
        # format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        # format.xml  { render :xml => @word.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    translation = Translation.find(params[:id])
    
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
