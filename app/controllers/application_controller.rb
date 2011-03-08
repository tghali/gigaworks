class ApplicationController < ActionController::Base
  include WardenHelper
  include UrlHelper
  
  before_filter :authenticate
  
  protect_from_forgery

private
  def ensure_user_is_not_signed_in
    if current_user
      if params[:action] == 'new'
        flash[:error] = "You are currently signed in. The action you requested will require you to sign out."
      else
        redirect_to :action => 'new'
      end
    end
  end
  
end
