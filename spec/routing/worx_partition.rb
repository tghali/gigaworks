require 'spec_helper'

describe "worx subdomain urls" do
  
  setup do |session|
    session.host! "example.com"
  end
  
  it "routes the worx subdomain" do
    { :get => "http://worx.gigavine.com" }.should route_to(
      :controller => "dashboard",
      :action => "index"
    )
  end
  
  it "generates subdomained routes to gigaworx" do
    controller.request.host = 'subdomain.test.com'
    
    raise dashboard_url.inspect
    # {:get => dashboard_url}.
    #       should route_to("http://worx.gigavine.com/")
  end
  
  it "generates subdomained routes to gigaworx" do
    controller.request.host = 'subdomain.test.com'
    
    raise url_for(:controller => "dashboard", :action => "index").inspect
    # {:get => dashboard_url}.
    #       should route_to("http://worx.gigavine.com/")
  end
  
end