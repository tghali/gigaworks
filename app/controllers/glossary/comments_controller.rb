class Glossary::CommentsController < Glossary::GlossaryController
  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(glossary_sentence_path @comment.commentable) }
      format.xml  { head :ok }
    end
  end

  def create
    @commentable = Sentence.find(params[:sentence_id])
    @comment = @commentable.comments.build(params[:comment])
    @comment.author = current_user
    
    authorize! :create, @comment
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(glossary_sentence_path @commentable) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        # TODO: ensure that if the comment form has errors it displays them and it is opened at page load
        format.html { redirect_to(glossary_sentence_path @commentable) }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
end
