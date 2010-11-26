Warden::Strategies.add(:sign_in) do
  
  def valid?
    params['session']['user_name_or_email'] || params['session']['password']
  end
  
  def authenticate!
    user = User.authenticate(params['session']['user_name_or_email'], params['session']['password'])
    if user
      env["rack.session.options"][:expire_after] = params['session']['remember_me'] ? 2.days : 15.minutes
      success!(user)
    else
      fail!("Could not log in")
    end
  end
  
end