class ApplicationController < ActionController::Base
  include WardenHelper
  before_filter :authenticate
  
  protect_from_forgery
  
  
end
