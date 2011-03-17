class Glossary::CommentsController < Glossary::GlossaryController
  def destroy
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable_type.constantize.find(@comment.commentable_id)
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(send("glossary_#{@commentable.class.to_s.underscore}_path", @commentable)) }
      format.xml  { head :ok }
    end
  end

  def create
    @comment = Comment.new(params[:comment])
    @commentable = params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id])
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(send("glossary_#{@commentable.class.to_s.underscore}_path", @commentable)) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { redirect_to(send("glossary_#{@commentable.class.to_s.underscore}_path", @commentable)) }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
end
