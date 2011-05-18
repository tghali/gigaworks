class ContactsController < ActionController::Base
  def create
    @contact = Contact.new(params[:contact])
    if @contact.valid?
      ContactMailer.new(@contact).deliver
      flash[:notice] = "Message sent! Thank you for conacting us."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
end