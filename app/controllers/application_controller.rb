class ApplicationController < ActionController::Base
  include WardenHelper
  # include UrlHelper
  
  before_filter :authenticate
  
  protect_from_forgery
  
  
end
