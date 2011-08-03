class Schedule::ScheduleController < ApplicationController
	 layout 'admin/gigaclient'
  def show
   redirect_to :action => 'dashboard'
 end
 
 def dashboard
   
  end
  
  def glossary
	@sentences = Sentence.find(:all,:limit => 100)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sentences }
    end
  end
 
end
