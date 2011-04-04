require 'spec_helper'

# This way of testing request urls might make sense in rails 3.0.6
describe "worx subdomain" do
  
  it "allows me to peek into url generation" do
    u = Factory :user
    post 'http://worx.gigavine.com/sign_in', :session => {:user_name_or_email => u.user_name, :password => "big secret"}
    get 'http://worx.gigavine.com'
    response.status.should eql(200)
  end
  
  it "keeps one cookie jar for domain and its subdomains" do
    u = Factory :user
    post "http://example.org/sign_in", :session => {:user_name_or_email => u.user_name, :password => "big secret"}

    get "http://worx.example.org"
    response.status.should eql(200)
  end
  
end