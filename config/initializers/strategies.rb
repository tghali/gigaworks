Warden::Strategies.add(:sign_in) do
  
  def valid?
    params['session']['user_name_or_email'] && params['session']['password']
  end
  
  def authenticate!      
    user = User.authenticate(params['session']['user_name_or_email'], params['session']['password'])
    
    if user
      session[:remember_me] = [user.id, user.salt] if params['session']['remember_me']
      success!(user)
    else
      fail!(:'account.user_not_found')
    end
  end
  
end

Warden::Strategies.add(:remember) do
  
  def valid?
    session[:remember_me]
  end
  
  def authenticate!      
    user = User.authenticate_remember_me(*session[:remember_me])
    
    if user
      success!(user)
    else
      fail!
    end
  end
  
end