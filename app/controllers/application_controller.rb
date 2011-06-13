require 'gdocs4ruby'
class ApplicationController < ActionController::Base
  include WardenHelper
  include UrlHelper
  include LogActionHelper
  
  before_filter :authenticate
  include GDocs4Ruby
  
  protect_from_forgery

  def setup
    @account = Service.new()
    @account.debug = true
    @account.authenticate('sharma.nyros@gmail.com', 'nyros123')
 end

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
