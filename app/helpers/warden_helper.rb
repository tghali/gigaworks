module WardenHelper
  extend ActiveSupport::Concern

  # included do
  #   helper_method :warden, authenticate
  # end
  
  def warden
    request.env['warden']
  end
  
  def authenticate
     client_contact = ClientContact.find_by_gigauser_id(current_user) if current_user

      if !client_contact.blank?
        env['warden'].authenticated? && client_contact.login_access == "open" or throw(:warden, :message => t(:'account.must_have_access'))
      else
        env['warden'].authenticated? or throw(:warden, :message => t(:'account.must_sign_in'))
      end
  end
  
  def authenticate_as_admin
    env['warden'].authenticated? && current_user.roles.include?(:admin) or throw(:warden, :message => t(:'account.must_sign_in_as_admin'))
  end
  
  # Used in redirects to send the user to the last relevant page he visited before logging in or
  # performing some other action that requires a redirect.
  # def previous_page_or_home
  #   current_session.previous_page || root_url
  # end
  
  # Returns the user object authorized by warden.
  def current_user
   warden.user
  end
  
  # # Returns the current session
  # def current_session
  #   @current_session ||= UserSession.new(session)
  # end
  # 
  # # Returns the user's permissions for cancan
  # # TODO: make more general for use with warden
  # def current_ability
  #   @current_ability ||= Ability.new(current_user)
  # end

end