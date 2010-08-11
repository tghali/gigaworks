class HomeController < ApplicationController
  def index
    render :inline => Rails::Info.to_html
  end
end
