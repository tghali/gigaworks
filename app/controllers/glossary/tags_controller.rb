class Glossary::TagsController < Glossary::GlossaryController
  def destroy
    @tag = Tag.find(params[:id])
    authorize! :destroy, @tag
    
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to(glossary_sentence_path @tag.taggable) }
      format.xml  { head :ok }
    end
  end

  def create
    @taggable = Sentence.find(params[:sentence_id])
    @tag = @taggable.tags.build(params[:tag])
    
    authorize! :create, @tag
    
    respond_to do |format|
      if @tag.save
        format.html { redirect_to(glossary_sentence_path @taggable) }
        format.xml  { render :xml => @tag, :status => :created, :location => @tag }
      else
        # TODO: ensure that if the comment form has errors it displays them and it is opened at page load
        format.html { redirect_to(glossary_sentence_path @taggable) }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end
end