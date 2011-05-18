class ContactMailer < ActionMailer::Base
  def new(contact)
    @from        = contact.email
    @sent_on     = Time.now
    @contact     = contact
    
    mail(:to      => @contact.email_to,
         :from    => @contact.email,
         :subject => "Gigavine: #{ 'Call - ' if contact.request_call? } email from - #{contact.name} - #{contact.email}")
  end
end
