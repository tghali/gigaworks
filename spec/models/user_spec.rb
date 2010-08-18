require 'spec_helper'

describe User do
  
  describe "creation" do
    
    it "accepts contact details too" do
      form = {:name => 'ninja666', :password => 'big secret', :password_confirmation => 'big secret',
              :contact_attributes => {:first_name => 'John', :second_name => 'Smith',
                                      :email => 'john.smith@example.com'}}
                                      
      u = User.create! form
      
      u.contact.first_name.should eql(form[:contact_attributes][:first_name])
    end
    
    it "accepts organization details too" do
      pending
    end
    
    it "accept contact details with provided organization" do
      pending
    end
    
    it "from contact" do
      pending
    end
  end
  
  describe "verification" do
    
  end
  
  describe "password reset" do
    
  end
  
  describe "deleting a user" do
    
  end
  
  describe "subject" do
    
  end
end