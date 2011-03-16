class Glossary::CommentsController < ApplicationController
  def destroy
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable_type.constantize.find(@comment.commentable_id)
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(send("glossary_#{@commentable.class.to_s.underscore}_path", @commentable)) }
      format.xml  { head :ok }
    end
  end
end
