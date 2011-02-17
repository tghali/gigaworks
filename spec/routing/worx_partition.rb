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
    raise dashboard_url.inspect
    # {:get => dashboard_url}.
    #       should route_to("http://worx.gigavine.com/")
  end
end