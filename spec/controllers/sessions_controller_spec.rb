require 'spec_helper'

describe SessionsController do
  it "authenticates user" do
    user = mock_model(User, :email => 'me@example.com').as_null_object
    request.env['warden'] = mock(Warden, :authenticate => user, :authenticate! => user, :authenticated? => true)
    
    post :new, {"remember_me"=>"0", "user_name_or_email"=> user.email, "password"=>"big secret"}
  end
end
