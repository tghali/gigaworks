require 'spec_helper'

describe "worx subdomain urls" do
  
  class Controllerish
    include ::Rails.application.routes.url_helpers
    Controllerish.default_url_options[:host] = 'example.com'
    
    def url_for(*args)
      p args.inspect
      super *args
    end
  end
  
  def controller
    Controllerish.new
  end
  
  it "has a dashboard controller for the worx subdomain" do
    debugger
    {:get => "http://worx.example.com"}.should route_to(
      :controller => "dashboard",
      :action => "index")
  end
  
  it "generates a full url to reach the dashboard" do
    {:get => controller.dashboard_url}.should route_to(
      :controller => 'dashboard',
      :action => "index")
  end
  
  it "generates a full url to that reaches the dashboard" do
    {:get => controller.url_for(:controller => "dashboard", 
                                :action => "index",
                                :subdomain => 'worx')}.should route_to(
       :controller => 'dashboard',
       :action => "index")
  end
  
end