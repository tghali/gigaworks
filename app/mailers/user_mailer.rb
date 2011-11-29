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
  def local_ip
  orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true # turn off reverse DNS resolution temporarily

  UDPSocket.open do |s|
    s.connect '64.233.187.99', 1
    s.addr.last
  end
ensure
  Socket.do_not_reverse_lookup = orig
end

    def submit_brief(details,myfile,section,browse)
    @briefdetail = details
    @userdetail = local_ip
    @details = browse
    #~ @filepath = details.attachment.url
    attachments["#{details.attachment_file_name}"] = File.read("#{myfile}")
    #mail(:to => details.email, :subject => "#{section} page data")
   mail(:to => 'prohini_nyros@yahoo.com', :subject => "#{section} page data")  
    
#mail(:to => 'info@gigavine.com', :subject => "#{section} page data")       
    end

  
  
  
end
