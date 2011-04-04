class SignInStrategy < Warden::Strategies::Base
  def valid?
    params['session']['user_name_or_email'] && params['session']['password']
  end
  
  def authenticate!      
    user = User.authenticate(params['session']['user_name_or_email'], params['session']['password'])

    if user
      user.session_expiry = (params['session']['remember_me'] == '1') ? 2.months.from_now : 1.hour.from_now
      success!(user)
    else
      fail('Wrong user name or password')
    end
  end
end
Warden::Strategies.add(:sign_in, SignInStrategy)
