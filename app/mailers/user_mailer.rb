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
      def talent_invite(uname,pass,details)
      @unm = uname
      @pass=pass
      @talent=details.first_name

    mail(:to => details.email, :subject => "Successful registration with Gigavine")
    #@invite.sent_at Time.now
  end
      def client_invitation(uname,pass,details)
      @unm = uname
      @pass=pass
      @talent=details.first_name

    mail(:to => details.email, :subject => "Successful registration with Gigavine")
    #@invite.sent_at Time.now
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

    def submit_brief(details,myfile,section,browse,ipadd,location)
    @briefdetail = details
    @userdetail = ipadd
    @details = browse
    @country=location
       if browse =~ /Safari/
          unless browse =~ /Chrome/
            @version = browse.split('Version/')[1].split(' ').first.split('.').first
            @browser = 'Safari'
          else
            @version = browse.split('Chrome/')[1].split(' ').first.split('.').first
            @browser = 'Chrome'
          end
        elsif result =~ /Firefox/
          @version = browse.split('Firefox/')[1].split('.').first
          @browser = 'Firefox '
        elsif result =~ /Opera/
          @version = browse.split('Version/')[1].split('.').first
          @browser = 'Opera'
        elsif result =~ /MSIE/
          @version = browse.split('MSIE')[1].split(' ').first
          @browser = 'Microsoft Internet Explorer '
        end
    #~ @filepath = details.attachment.url
    attachments["#{details.attachment_file_name}"] = File.read("#{myfile}")
    #mail(:to => details.email, :subject => "#{section} page data")
   #mail(:to => 'umamahesh_nyros@yahoo.com', :subject => "#{section} page data")
   #mail(:to => 'prohini_nyros@yahoo.com', :subject => "#{section} page data")    
    
mail(:to => 'info@gigavine.com', :subject => "#{section} page data")       
    end

  
  
  
end
