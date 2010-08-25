Warden::Strategies.add(:sign_in) do
  
  def valid?
    params['session']['user_name_or_email'] || params['session']['password']
  end
  
  def authenticate!
    user = User.authenticate(params['session']['user_name_or_email'], params['session']['password'])
    if user 
      success!(user)
    else
      fail!("Could not log in")
    end
  end
  
end