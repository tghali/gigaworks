class AdminController < ApplicationController
  before_filter :authenticate_as_admin
  
  def index
    render :text => 'booyah'
  end
end
