class UserMailer < ActionMailer::Base
  default :from => "no-reply@gigavine.com"
  
  def invite(invite)  
    @invite = invite
    mail(:to => invite.recipient.email, :subject => "Gigaworx invite")
    @invite.sent_at Time.now
  end
  
  def password_reset(user)  
    @user = user  
    mail(:to => user.email, :subject => "Password reset")  
  end
  
    def client_invite(invite)
      @invite = invite

    mail(:to => invite.gigaclient.email, :subject => "Gigaworx invite")
    @invite.sent_at Time.now
  end
  
  def client_contact_invite(invite)
      @invite = invite
    mail(:to => invite.recipient.email, :subject => "Client Users Invitation")
    @invite.sent_at Time.now
  end
  
 def registration_details(gigauser,gigaclient)
	  @user = gigauser
	  @gigaclient = gigaclient
	  mail(:to => gigauser.email, :subject => "Gigavine Login Details")
end
  
  #~ def submit_brief(name, ulf, filename, to_mail)
    #~ mail(:to => to_mail, :subject => "Technology page data")
    
     #~ attachment :content_type => "application/pdf",
      #~ :filename => filename, 
     #~ :body=> File.read(ulf)
  #~ end  
  
    def submit_brief(file_name,email,myfile,section)
    #~ @filepath = details.attachment.url
    attachments["#{file_name}"] = File.read("#{myfile}")
    mail(:to => email, :subject => "#{section} page data")    
    end

  
  
  
end
