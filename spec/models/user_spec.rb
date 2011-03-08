require 'spec_helper'
require "cancan/matchers"

describe User do
  
  describe "creation" do
    
    before(:each) do
      @form= {:user_name => 'ninja666', :password => 'big secret',
              :password_confirmation => 'big secret',
              :contact_attributes => {:first_name => 'John', :last_name => 'Smith',
                                      :email => 'john.smith@example.com'}}
    end
    
    it "accepts contact details too" do
      u= User.create! @form
      
      u.contact.first_name.should eql(@form[:contact_attributes][:first_name])
    end
    
    it "accepts organisation details too" do
      organisation_attributes = {:organisation_attributes => {:name => 'Gigavine',
                                                              :country_code => 'uk'}}
                                                              
      u= User.create! @form.merge(:contact_attributes => @form[:contact_attributes].merge(organisation_attributes))
      
      u.contact.organisation.name.should eql(organisation_attributes[:organisation_attributes][:name])
    end
    
    it "accept contact details with provided organisation" do
      o= Organisation.create(:name => 'Gigavine', :country_code => 'uk')
      
      u= User.create! @form.merge(:contact_attributes => @form[:contact_attributes].merge(:organisation => o))
      u.contact.organisation.should eql(o)
    end
    
    it "from contact" do
      c= Contact.new @form[:contact_attributes]
      
      u= User.create! @form.except[:contact_attributes].merge(:contact => c)
      u.contact.first_name.should eql(@form[:contact_attributes][:first_name])
    end
    
  end
  
  describe "departement association helpers" do
    it "verifies the presence of a department" do
      u = Factory :translator
      u.reload

      u.departements.has?(:languages).should be_true
      
      ability = Ability.new(u)
      
      ability.should be_able_to(:create, Sentence)
    end
  end
  
end