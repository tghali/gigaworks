class ApplicationController < ActionController::Base
  protect_from_forgery

protected
  # Used in redirects to send the user to the last relevant page he visited before logging in or
  #  performing some other action that requires a redirect.
  def previous_page_or_home
    current_session.previous_page || root_url
  end
  
  # Returns the user object and memoizes it.
  def current_user
    @current_user ||= current_session.get_user
  end
  
  # Returns the current session
  def current_session
    @current_session ||= UserSession.new(session)
  end
  
  # Returns the user's permissions for cancan
  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
  
end
