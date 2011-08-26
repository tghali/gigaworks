module Warden::Mixins::Common
  def request
    @request ||= ActionDispatch::Request.new(env)
  end

  def cookies
    request.cookie_jar
  end
end

class RememberMeStrategy < Warden::Strategies::Base
  def valid?
    cookies.signed['_gigavine_warden']
  end
  
  def authenticate!      
    user = User.authenticate_remember_me(*cookies.signed['_gigavine_warden'])
    
    if user
      success!(user)
    else
      fail('Invalid remember token')
    end
  end
end
Warden::Strategies.add(:remember_me, RememberMeStrategy)


class SignInStrategy < Warden::Strategies::Base
  def valid?
    params['session']['user_name_or_email'] && params['session']['password']
  end
  
  def authenticate!
    user = User.authenticate(params['session']['user_name_or_email'], params['session']['password'])
    
    if user
      
      #~ if params['session']['remember_me'] == '1'
        #~ cookies.signed['_gigavine_warden'] = {:value => [user.id, user.salt, 6.months.from_now], :domain  => :all}
      #~ end
      #~ success!(user)
      
     client_contact = ClientContact.find_by_gigauser_id(user.id)
		 if !client_contact.blank? &&  client_contact.login_access == "block"
			 fail('Your account was blocked temporarily. Please contact administrator.')
		else
			
				      if params['session']['remember_me'] == '1'
                cookies.signed['_gigavine_warden'] = {:value => [user.id, user.salt, 6.months.from_now], :domain  => :all}
				      end
				      success!(user)
		end	
      

    else
      fail('Wrong user name or password')
    end
  end
end
Warden::Strategies.add(:sign_in, SignInStrategy)
