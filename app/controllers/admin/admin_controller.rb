class Admin::AdminController < ApplicationController
  before_filter :authenticate_as_admin
  # before_filter :can_admin?
  
  
private
  
  def can_admin?
    authorize! :administer
  end
  
end
