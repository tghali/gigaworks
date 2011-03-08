module Warden::Mixins::Common
  def request
    @request ||= ActionDispatch::Request.new(env)
  end

  def cookies
    request.cookie_jar
  end
end

class RememberStrategy < Warden::Strategies::Base
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
Warden::Strategies.add(:remember, RememberStrategy)

class SignInStrategy < Warden::Strategies::Base
  def valid?
    params['session']['user_name_or_email'] && params['session']['password']
  end
  
  def authenticate!      
    user = User.authenticate(params['session']['user_name_or_email'], params['session']['password'])

    if user
      cookies.signed.permanent['_gigavine_warden'] = [user.id, user.salt] if params['session']['remember_me'] == '1' #TODO: using == '1' isn't pretty
      success!(user)
    else
      fail('Wrong user name or password')
    end
  end
end
Warden::Strategies.add(:sign_in, SignInStrategy)
