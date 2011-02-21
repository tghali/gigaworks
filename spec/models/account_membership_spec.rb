require 'spec_helper'

describe AccountMembership do
  
  it "creates users tied to a contact bound to an account" do
    # premise
    organisation = Factory :organisation, :name => 'Somecorp'
    gigavine = Factory :organisation, :name => 'Gigavine', :country_code => 'gb'
    
    salesperson = Factory :user, :contact => (Factory :contact, :organisation => gigavine)
    salesperson.departements.add(:sales)
    
    
    c = Factory :contact, :organisation => organisation
    
    organisation.contacts.first.should eql(c)
    
    # create an account
    organisation.create_account(:sales_representative => salesperson.departements.find(:sales))
    
    organisation.account.users.create(:contact => c)
    
    c.user.account_membership.should_not be_nil
  end
  
  
end
