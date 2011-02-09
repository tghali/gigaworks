class Glossary::DefinitionsController < Glossary::GlossaryController
  
  before_filter :load_words
  
  def index
    
    load_words
    @word = Word.find(params[:word_id])
    
    respond_to do |format|
      format.html {render 'glossary/words/show'}
      # format.xml  { render :xml => @words }
    end
  end

  def new
    @word = Word.find(params[:word_id])
    @definition = @word.definitions.build
    @definition.examples.build(:language => @word.language)
    
    respond_to do |format|
      format.html {render :edit}
      # format.xml  { render :xml => @word }
    end
  end


  def edit
    @word = Word.find(params[:word_id])
    @definition = @word.definitions.find(params[:id])
    @definition.examples.build(:language => @word.language)
    @definition.translations.build
  end


  def create
    @word = Word.find(params[:word_id])
    @definition = @word.definitions.create(params[:definition])
    
    respond_to do |format|
      if @word.save
        format.html { redirect_to(glossary_word_path(@word), :notice => 'Word was successfully created.') }
        # format.xml  { render :xml => @word, :status => :created, :location => @word }
      else
        format.html { render :action => :edit }
        # format.xml  { render :xml => @word.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @word = Word.find(params[:word_id])
    @definition = @word.definitions.find(params[:id])

    respond_to do |format|
      if @definition.update_attributes(params[:definition])
        format.html { redirect_to(glossary_word_path(@word), :notice => 'The definition was successfully updated.') }
        # format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        # format.xml  { render :xml => @word.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @word = Word.find(params[:id])
    @word.destroy

    respond_to do |format|
      format.html { redirect_to(glossary_words_url) }
      # format.xml  { head :ok }
    end
  end
  
end
