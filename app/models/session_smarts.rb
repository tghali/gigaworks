module SessionSmarts
  def initialize(session)
    @session = session
    @session[:created_at] ||= Time.now
    
    refresh_session if @session[:signin_expires]
    @session[:previous_page] = @session[:last_page]
  end
  
  def created_at
    @session[:created_at]
  end
  
  # Stores the url in the user session to provide a redirect after the signin.
  def remember_page(url)
    @session[:last_page] = url
  end
  
  # Provides the url to redirect to for a signin.
  def previous_page
    @session[:previous_page]
  end
  
  def last_announcements_seen_on
    @session[:last_announcements_seen_on] ||= 1
  end
  
  def last_announcements_seen_now
    # we should have a mechanism to make sure you hide a message you haven't seen yet
    @session[:last_announcements_seen_on] = Time.now
  end
  # LEDO: add a visitor id method for metrics?
  # LEDO: add a function to gather the timezone from the location (you still need to cache it in the user model)
  
  # Sets the user id during the signin.
  def user_id=(id)
    @session[:user_id] = id
    @session[:signin_expires] = 1.hour.from_now
  end
  
  # Returns the user's id if the user is logged in
  def user_id
    @session[:user_id] unless stale_session?
  end
  
  # Returns _true_ if the user is logged in, otherwise returns _false_.
  def signed_in?
    @session[:user_id] && !stale_session? ? true : false
  end
  
  # Deletes user informations from the session.
  def signout
    @session[:signin_expires] = nil
    @session[:user_id] = nil
  end
  
  # Returns the user from a find, memoizing it in the controller saves a frequent method call.
  def get_user
    user_id ? User.active.find_by_id(user_id) : nil
  end
  
  # Sets the signin expiration to one year from now.
  def remember_me!
    @session[:signin_expires] = 1.year.from_now
  end
  
  # Returns true if the session is stale.
  def stale_session?
    if @session[:signin_expires]
      @session[:signin_expires] < Time.now ? true : false
    else
      true
    end
  end
  
  private
    
    # Renews session expiration for the next 45 minutes if the session is still fresh
    def refresh_session
      refresh_time = 45.minutes.from_now
      if !stale_session? && @session[:signin_expires] < refresh_time
        @session[:signin_expires] = refresh_time
      end
    end
    
end