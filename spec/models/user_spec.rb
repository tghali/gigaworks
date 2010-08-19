require 'spec_helper'

describe User do
  
  describe "creation" do
    
    before(:each) do
      @form= {:name => 'ninja666', :password => 'big secret', :password_confirmation => 'big secret',
              :contact_attributes => {:first_name => 'John', :last_name => 'Smith',
                                      :email => 'john.smith@example.com'}}
    end
    
    it "accepts contact details too" do
      u= User.create! @form
      
      u.contact.first_name.should eql(@form[:contact_attributes][:first_name])
    end
    
    it "accepts organization details too" do
      organization_attributes = {:organization_attributes => {:name => 'Gigavine',
                                                              :country_code => 'uk'}}
                                                              
      u= User.create! @form.merge(:contact_attributes => @form[:contact_attributes].merge(organization_attributes))
      
      u.contact.organization.name.should eql(organization_attributes[:organization_attributes][:name])
    end
    
    it "accept contact details with provided organization" do
      o= Organization.create(:name => 'Gigavine', :country_code => 'uk')
      
      u= User.create! @form.merge(:contact_attributes => @form[:contact_attributes].merge(:organization => o))
      u.contact.organization.should eql(o)
    end
    
    it "from contact" do
      c= Contact.new @form[:contact_attributes]
      
      u= User.create! @form.except[:contact_attributes].merge(:contact => c)
      u.contact.first_name.should eql(@form[:contact_attributes][:first_name])
    end
    
  end
  
end